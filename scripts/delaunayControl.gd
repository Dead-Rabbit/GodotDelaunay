extends Node

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")

# 点相关
var pointNum = 3
var points = []

var tempTriangles = []

# 生成相关
var area_left = 200
var area_top = 400
var area_right = 800
var area_bottom = 500

func _ready():
	# 生成随机点
	GenerateRandomNodes()
	# 生成超级三角形的三个点
	GenerateSuperTrianglePoint()
	# 绘制随机点
	DrawNodes()

# 生成随机点
func GenerateRandomNodes():
	for i in range(pointNum):
		var randX = rand_range(area_left, area_right)
		var randY = rand_range(area_top, area_bottom)
		var point = DelaunayPoint.new(randX, randY)
		points.append(point)
	
# 生成超级三角形的三个点
func GenerateSuperTrianglePoint():
	var gen_left = area_left - 10
	var gen_top = area_top - 10
	var gen_right = area_right + 10
	var gen_bottom = area_bottom + 10
	
	var width = gen_right - gen_left
	var height = gen_bottom - gen_top
	points.append(DelaunayPoint.new(gen_left - height, gen_bottom))
	points.append(DelaunayPoint.new(gen_right + height, gen_bottom))
	points.append(DelaunayPoint.new(gen_left + width / 2, gen_top - width / 2))
	
# 绘制点
func DrawNodes():
	for point in points:
		point.draw(self)
