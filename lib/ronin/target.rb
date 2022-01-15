#
# ronin-db - A common database library for managing and querying security data.
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/model'

require 'dm-timestamps'
require 'fileutils'

module Ronin
  #
  # Represents an {Address} targeted by a {Campaign}.
  #
  class Target

    include Model

    # Primary key of the target
    property :id, Serial

    # The campaign the target belongs to
    belongs_to :campaign

    # The host being targeted
    belongs_to :address

    # Defines the `created_at` timestamp
    timestamps :created_at

    # The organization that is being targeted
    has 1, :organization, through: :address

    # Validates the uniqueness of the address and the campaign.
    validates_uniqueness_of :address, scope: [:campaign]

    #
    # Converts the target to a String.
    #
    # @return [String]
    #   The address of the target.
    #
    # @since 1.0.0
    #
    # @api public
    #
    def to_s
      self.address.to_s
    end

  end
end
