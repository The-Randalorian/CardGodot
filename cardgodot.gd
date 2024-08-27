extends XRCamera3D

var xr_interface: MobileVRInterface
var cardboard_params = {
	"vendor":"Google",
	"model":"Cardboard I/O 2015",
	"screen_to_lens_distance":0.03680000081658363,
	"inter_lens_distance":0.06199999898672104,
	"left_eye_field_of_view_angles":[50,50,50,50],
	"vertical_alignment":0,
	"tray_to_lens_distance":0.03500000014901161,
	"distortion_coefficients":[0.26260000467300415,0.2678999900817871],
	"has_magnet":false,
	"primary_button":3
	}
const m_to_cm = 100

@export var eye_height = 1.67  # m, adjusted for the creator
@export var display_width = 14.76 # cm, adjusted for the creator (pixel 6)
@export var oversample = 1.5 # %, adjusted for the creator

func _ready():
	var xr_interface = XRServer.find_interface("Native mobile")
	xr_interface.display_to_lens = cardboard_params["screen_to_lens_distance"] * m_to_cm
	xr_interface.iod = cardboard_params["inter_lens_distance"] * m_to_cm
	xr_interface.k1 = cardboard_params["distortion_coefficients"][0]
	xr_interface.k2 = cardboard_params["distortion_coefficients"][1]
	xr_interface.eye_height = eye_height
	xr_interface.oversample = oversample
	xr_interface.display_width = display_width
	if xr_interface and xr_interface.initialize():
		get_viewport().use_xr = true
