#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'prawn'
require 'prawn-svg'

ROOT = 'Mac/AAP2019.fbpub'
SUBSTRATE_PREFIX= "#{ROOT}/files/assets/common/page-html5-substrates"
TEXT_PREFIX = "#{ROOT}/files/assets/common/page-textlayers"
VECTOR_PREFIX = "#{ROOT}/files/assets/common/page-vectorlayers"
PAGE_RANGE = 1..1202
OUTPUT = 'aap2019.pdf'

Prawn::Font::AFM.hide_m17n_warning = true

Prawn::Document.generate(OUTPUT) do
  font_families.update(
    'Arial' => {
      :normal => "#{File.dirname(__FILE__)}/Arial.ttf",
      :bold => "#{File.dirname(__FILE__)}/Arial-Bold.ttf",
      :italic => "#{File.dirname(__FILE__)}/Arial-Italic.ttf",
      :bold_italic => "#{File.dirname(__FILE__)}/Arial-Bold-Italic.ttf",
    }
  )

  font 'Arial'

  PAGE_RANGE.each do |i|
    page = i.to_s.rjust(4, '0')
    substrate = "#{SUBSTRATE_PREFIX}/page#{page}_4.jpg"
    text = "#{TEXT_PREFIX}/page#{page}_1.png"
    vector = "#{VECTOR_PREFIX}/#{page}.svg"

    pos = cursor
    image substrate, :fit => [bounds.right, bounds.top], :at => [0, pos]
    #svg IO.read(vector), :at => [0, pos]
    image text, :fit => [bounds.right, bounds.top], :at => [0, pos] if Pathname.new(text).exist?
    start_new_page
  end
end