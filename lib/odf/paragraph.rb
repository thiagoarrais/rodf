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

require 'rubygems'
require 'builder'

require 'odf/container'
require 'odf/hyperlink'
require 'odf/span'

module ODF
  class Paragraph < Container
    def initialize(content = nil)
      span(content)
    end

    def xml
      Builder::XmlMarkup.new.text:p do |xml|
        xml << content_parts_xml
      end
    end

    def content_parts
      @content_parts ||= []
    end

    def content_parts_xml
      content_parts.map {|p| p.xml}.join
    end

    def span(*args)
      s = Span.new(*args)
      yield s if block_given?
      content_parts << s
      s
    end

    def link(*args)
      l = Hyperlink.new(*args)
      yield l if block_given?
      content_parts << l
      l
    end
    alias a link

    def <<(content)
      span(content)
    end

    def method_missing(style, *args)
      span(style, *args)
    end
  end
end