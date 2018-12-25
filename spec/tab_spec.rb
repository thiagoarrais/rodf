# Copyright (c) 2010 Thiago Arrais
#
# This file is part of rODF.
#
# rODF is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.

# rODF is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with rODF.  If not, see <http://www.gnu.org/licenses/>.

require_relative 'spec_helper'

require_relative '../lib/rodf/paragraph'
require_relative '../lib/rodf/tab'

describe RODF::Tab do
  it "should be placed inside paragraphs" do
    output = RODF::Paragraph.create {|p|
      p << "Tab"
      p.tab
      p << "test"
    }
    output.should have_tag("//text:p/*", count: 3)
    output.should have_tag("//text:tab")
  end
end

