# encoding: utf-8
module BloXL
  class Bar < Block
    def _render(sheet, r, c)
      max_w, max_h, dc = 0, 0, 0
      children.each do |child|
        w, h = child.render(sheet, r, c + dc)
        dc += w
        max_h = [max_h, h].max
        max_w = dc
      end
      [max_w, max_h]
    end
  end
end
