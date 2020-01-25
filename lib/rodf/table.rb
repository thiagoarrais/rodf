require 'builder'

require_relative 'column'
require_relative 'container'
require_relative 'row'

module RODF
  class Table < Container
    contains :rows, :columns

    def initialize(title = nil)
      @title = title
      @last_row = 0

      super
    end

    alias create_row row
    def row(options = {}, &contents)
      create_row(next_row, options) do |row|
        if contents
          if contents.arity.zero?
            row.instance_exec(row, &contents)
          else
            yield(row)
          end
        end
      end
    end

    def add_rows(*rows)
      rows = rows.first if rows.first.first.is_a?(Array)
      rows.each do |row|
        created = self.row
        created.add_cells row
      end
    end

    def xml
      Builder::XmlMarkup.new.table:table, 'table:name' => @title do |xml|
        xml << columns_xml
        xml << rows_xml
      end
    end
  private
    def next_row
      @last_row += 1
    end
  end
end
