module ListArrangementHelper
  def list_arrangement_actions
    actions = {
      "focus": "focus",
      "blur": "blur",
      "click": "click",
      "keydown.up": "moveCursorUp:prevent",
      "keydown.right": "moveCursorRight:prevent",
      "keydown.down": "moveCursorDown:prevent",
      "keydown.left": "moveCursorLeft:prevent",
      "keydown.shift+up": "moveCursorUp:prevent",
      "keydown.shift+right": "moveCursorRight:prevent",
      "keydown.shift+down": "moveCursorDown:prevent",
      "keydown.shift+left": "moveCursorLeft:prevent",
      "keydown.space": "toggleMoveMode:prevent",
      "keydown.esc": "cancelMoveMode:prevent",
    }

    actions.map { |action, target| "#{action}->list-arrangement##{target}" }.join(" ")
  end
end
