require 'spec_helper'
require 'ronin/db/cli/database_options'
require 'ronin/db/cli/command'

describe Ronin::DB::CLI::DatabaseOptions do
  module TestDatabaseOptions
    class Command < Ronin::DB::CLI::Command
      include Ronin::DB::CLI::DatabaseOptions
    end
  end

  let(:command_class) { TestDatabaseOptions::Command }
  subject { command_class.new }

  describe "#db_config" do
    context "when neither options[:db] nor options[:db_uri] are set" do
      it "must default to connecting to the :default database" do
        expect(subject.db_config).to eq(Ronin::DB.config[:default])
      end
    end

    context "when options[:db] is set" do
      let(:db_name) { :test }
      let(:config) do
        {
          db_name => {
            adapter: 'sqlite3',
            database: '/path/to/db.sqlite3'
          }
        }
      end

      before do
        allow(Ronin::DB).to receive(:config).and_return(config)

        subject.options[:db] = db_name
      end

      it "must return the database configuration for options[:db]" do
        expect(subject.db_config).to eq(Ronin::DB.config[db_name])
      end
    end

    context "when options[:db_uri] is set" do
      let(:db_uri)     { "postgres://user:password@host:1234/database" }
      let(:parsed_uri) { subject.parse_uri(subject.options[:db_uri])   }

      before { subject.options[:db_uri] = db_uri }

      it "must return the parsed URI for options[:db_uri]" do
        expect(subject.db_config).to eq(parsed_uri)
      end
    end

    context "when options[:db_file] is set" do
      let(:db_file) { '/path/to/db.sqlite3' }

      before { subject.options[:db_file] = db_file }

      it "must return {sqlite3: ...} Hash containing the options[:db_file] value" do
        expect(subject.db_config).to eq(sqlite3: db_file)
      end

      context "when the options[:db_file] path is relative" do
        let(:db_file) { 'path/to/foo/../db.sqlite3' }

        let(:expanded_db_path) { File.expand_path(db_file) }

        it "must expand the path" do
          expect(subject.db_config).to eq(sqlite3: expanded_db_path)
        end
      end
    end
  end

  describe "#db_connect" do
    it "must call ActiveRecord::Base.establish_connection with #config" do
      expect(ActiveRecord::Base).to receive(:establish_connection).with(subject.db_config)

      subject.db_connect
    end
  end
end
