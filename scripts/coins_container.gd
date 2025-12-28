extends HBoxContainer

@onready var coin_label: Label = $coin_label

func _ready():
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)

func update_coin(amount: int):
	coin_label.text = "%d" % amount
