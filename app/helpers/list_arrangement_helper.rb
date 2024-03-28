module ListArrangementHelper
  def list_arrangement_actions
    actions = {
      "focus": "focus",
      "blur": "blur",
      "keydown.up": "moveCursorUp",
      "keydown.right": "moveCursorRight",
      "keydown.down": "moveCursorDown",
      "keydown.left": "moveCursorLeft",
      "keydown.shift+up": "moveCursorUp",
      "keydown.shift+right": "moveCursorRight",
      "keydown.shift+down": "moveCursorDown",
      "keydown.shift+left": "moveCursorLeft",
      "keydown.space": "toggleMoveMode",
      "keydown.esc": "cancelMoveMode",
    }

    actions.map { |action, target| "#{action}->list-arrangement##{target}:prevent" }.join(" ")
  end
end
