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

require 'ronin/model'

require 'dm-timestamps'

module Ronin
  #
  # Associates a {HostName} with an {IPAddress}.
  #
  class HostNameIPAddress

    include Model

    # The primary-key of the join model.
    property :id, Serial

    # The host name pointing to the IP Address
    belongs_to :host_name

    # The IP Address
    belongs_to :ip_address, model: 'IPAddress'

    # Tracks when a IP Address is associated with a host name
    timestamps :created_at

  end
end
