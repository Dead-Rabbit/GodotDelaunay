extends Node

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")

# 点相关
var pointNum = 10
var points = []

# 生成相关
var area_left = 200
var area_top = 100
var area_right = 900
var area_bottom = 500
# 生成随机点
func GenerateRandomNodes():
	for i in range(pointNum):
		var randX = rand_range (area_left, area_right)
		var randY = rand_range (area_top, area_bottom)
		
		var sp = Sprite.new()
		sp.texture = load("res://sprite/point.png")
		sp.position = Vector2(randX, randY)
		self.add_child(sp)

# Called when the node enters the scene tree for the first time.
func _ready():
	# 生成随机点
	GenerateRandomNodes()
	var point = DelaunayPoint.new()

