extends Node

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")
var DelaunayTriangle = load("res://scripts/baseClass/DelaunayTriangle.gd")

# 生成相关
var area_left = 200
var area_top = 400
var area_right = 800
var area_bottom = 500

# 点相关
var pointNum = 3
var points = []
var superTrianglePoints = []

# 三角形相关
var superTriangle
var tempTriangles = []
var triangles = []

func _ready():
	# 生成随机点
	GenerateRandomNodes()
	# 生成超级三角形的三个点
	GenerateSuperTrianglePoint()
	# 绘制随机点
	DrawNodes()
	
	# 三角剖分算法
	Delaunay()

#input: 顶点列表(vertices)　　　　　　　　　　　　　　　　　　　　  　//vertices为外部生成的随机或乱序顶点列表
#output:已确定的三角形列表(triangles)
#　　　　初始化顶点列表
#　　　　创建索引列表(indices = new Array(vertices.length))　　　　//indices数组中的值为0,1,2,3,......,vertices.length-1
#　　　　基于vertices中的顶点x坐标对indices进行sort　　  　　　　　  //sort后的indices值顺序为顶点坐标x从小到大排序（也可对y坐标，本例中针对x坐标）
#　　　　确定超级三角形
#　　　　将超级三角形保存至未确定三角形列表（temp triangles）
#　　　　将超级三角形push到triangles列表
#　　　　遍历基于indices顺序的vertices中每一个点　　　　　　　　　  　//基于indices后，则顶点则是由x从小到大出现
#　　　　　　初始化边缓存数组（edge buffer）
#　　　　　　遍历temp triangles中的每一个三角形
#　　　　　　　　计算该三角形的圆心和半径
#　　　　　　　　如果该点在外接圆的右侧
#　　　　　　　　　　则该三角形为Delaunay三角形，保存到triangles
#　　　　　　　　　　并在temp里去除掉
#　　　　　　　　　　跳过
#　　　　　　　　如果该点在外接圆外（即也不是外接圆右侧）
#　　　　　　　　　　则该三角形为不确定        　　　　　　　　　     //后面会在问题中讨论
#　　　　　　　　　　跳过
#　　　　　　　　如果该点在外接圆内
#　　　　　　　　　　则该三角形不为Delaunay三角形
#　　　　　　　　　　将三边保存至edge buffer
#　　　　　　　　　　在temp中去除掉该三角形
#　　　　　　对edge buffer进行去重
#　　　　　　将edge buffer中的边与当前的点进行组合成若干三角形并保存至temp triangles中
#　　　　将triangles与temp triangles进行合并
#　　　　除去与超级三角形有关的三角形

func Delaunay():
	for point in points:
		var edgeBuffer = []
		var index = 0
		while index < tempTriangles.size():
			var tempTriangle = tempTriangles[index]
			tempTriangle.calculateCenterAndRadius()
			if tempTriangle.checkIfPointOutSideOnRight(point):
				print("right")
				tempTriangle.draw()
				# 则该三角形为Delaunay三角形，保存到triangles
				triangles.append(tempTriangle)
				# 在temp里去除掉
				tempTriangles.remove(index)
				index -= 1
			elif !tempTriangle.checkIfPointInside(point):
#　　　　　　　　 则该三角形为不确定        　　　　　　　　　     //后面会在问题中讨论
				print("Not Inside")
			elif tempTriangle.checkIfPointInside(point):
				print("Inside")
				# 将三边保存至edge buffer
				edgeBuffer.append(tempTriangle.line1)
				edgeBuffer.append(tempTriangle.line2)
				edgeBuffer.append(tempTriangle.line3)
				tempTriangles.remove(index)
				index -= 1
			else:
				print("None")
			
			index += 1
		
		# 对 Edge Buffer 进行去重
		var i = 0
		while i < edgeBuffer.size():
			var edge1 = edgeBuffer[i]
			var j = i + 1
			while j < edgeBuffer.size():
				var edge2 = edgeBuffer[j]
				if (edge1.compare(edge2)):
					edgeBuffer.remove(j)
					j = j - 1
				j += 1
				
			i += 1
				
		# 将edge buffer中的边与当前的点进行组合成若干三角形并保存至temp triangles中
		i = 0
		while i < edgeBuffer.size():
			var edge = edgeBuffer[i]
			var tempTriangle = DelaunayTriangle.new(edge.point1, edge.point2, point)
			tempTriangles.append(tempTriangle)
			i += 1

#　　　　将triangles与temp triangles进行合并
#　　　　除去与超级三角形有关的三角形
				

# 生成随机点
func GenerateRandomNodes():
	seed(OS.get_unix_time())
	
	for i in range(pointNum):
		var randX = rand_range(area_left, area_right)
		var randY = rand_range(area_top, area_bottom)
		var point = DelaunayPoint.new(randX, randY, points.size())
		points.append(point)
		points.sort_custom(DelaunayPoint, "sort_by_x")

	
# 生成超级三角形的三个点
func GenerateSuperTrianglePoint():
	var gen_left = area_left - 10
	var gen_top = area_top - 10
	var gen_right = area_right + 10
	var gen_bottom = area_bottom + 10
	
	var width = gen_right - gen_left
	var height = gen_bottom - gen_top
	
	var point1 = DelaunayPoint.new(gen_left - height, gen_bottom, points.size() + 1)
	var point2 = DelaunayPoint.new(gen_right + height, gen_bottom, points.size() + 2)
	var point3 = DelaunayPoint.new(gen_left + width / 2, gen_top - width / 2, points.size() + 3)
	superTrianglePoints.append(point1)
	superTrianglePoints.append(point2)
	superTrianglePoints.append(point3)
	
	superTriangle = DelaunayTriangle.new(point1, point2, point3)
	tempTriangles.append(superTriangle)
	triangles.append(superTriangle)
	
# 绘制点
func DrawNodes():
	for point in points:
		point.draw(self)
		print(point.x)
	
	for point in superTrianglePoints:
		point.draw(self)
