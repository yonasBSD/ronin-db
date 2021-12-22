#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2021 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-db.
#
# ronin-db is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-db is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-db.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/database/migrations/migrations'

module Ronin
  module Database
    module Migrations
      #
      # 1.0.0
      #
      migration :create_os_table do
        up do
          create_table :ronin_os do
            column :id, Integer, serial: true
            column :name, String, not_null: true
            column :version, String
          end

          create_index :ronin_os, :name
          create_index :ronin_os, :version
        end

        down do
          drop_table :ronin_os
        end
      end

      migration :populate_os_table do
        up do
          [
            'Linux',
            'FreeBSD',
            'OpenBSD',
            'NetBSD',
            'OS X',
            'Solaris',
            'UNIX',
            'windows'
          ].each do |name|
            adapter.execute(
              'INSERT OR IGNORE INTO ronin_os (name) VALUES (?)', name
            )
          end
        end

        down do
        end
      end
    end
  end
end
