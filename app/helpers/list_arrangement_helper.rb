module ListArrangementHelper
  def list_arrangement_actions
    actions = {
      "focus": "focus",
      "blur": "blur",
      "click": "click",
      "keydown.up": "moveUp:prevent",
      "keydown.right": "moveRight:prevent",
      "keydown.down": "moveDown:prevent",
      "keydown.left": "moveLeft:prevent",
      "keydown.shift+up": "moveUp:prevent",
      "keydown.shift+right": "moveRight:prevent",
      "keydown.shift+down": "moveDown:prevent",
      "keydown.shift+left": "moveLeft:prevent",
      "keydown.space": "toggleMoveMode:prevent",
      "keydown.esc": "cancelMoveMode:prevent",
    }

    actions.map { |action, target| "#{action}->list-arrangement##{target}" }.join(" ")
  end
end
