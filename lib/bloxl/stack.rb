# encoding: utf-8
module BloXL
  class Stack < Group
    protected
    
    def _render(sheet, r, c)
      max_h, max_w, dr = 0, 0, 0
      children.each do |child|
        w, h = child.render(sheet, r+dr, c)
        dr += h
        max_h = dr
        max_w = [w, max_w].max
      end
      [max_w, max_h]
    end
  end
end
