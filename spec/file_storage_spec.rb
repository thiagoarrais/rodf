require_relative 'spec_helper'

require_relative '../lib/rodf/text'
require "tempfile"

describe "file storage" do

  before do
    @default_internal = Encoding.default_internal
    @tempfilename = Tempfile.new("text").path
  end

  after do
    Encoding.default_internal = @default_internal
    File.unlink @tempfilename if File.exist? @tempfilename
  end

  it "should store files on disk" do
    RODF::Text.file(@tempfilename) {}

    File.exist?(@tempfilename).should be true
  end

  it "should work with Encoding.default_internal" do
    Encoding.default_internal = "UTF-8"

    RODF::Text.file(@tempfilename) {}
    File.exist?(@tempfilename).should be true
  end
end
