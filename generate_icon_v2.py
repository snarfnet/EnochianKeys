"""Enochian Keys - Unique Portal/Eye Icon - No text, abstract sacred geometry"""
from PIL import Image, ImageDraw, ImageFilter
import math, random

SIZE = 1024
img = Image.new('RGB', (SIZE, SIZE), (3, 3, 15))
draw = ImageDraw.Draw(img)

random.seed(777)

# Deep gradient background - vertical
for y in range(SIZE):
    ratio = y / SIZE
    r = int(3 + 12 * math.sin(ratio * math.pi * 0.8))
    g = int(3 + 6 * math.sin(ratio * math.pi * 0.8))
    b = int(15 + 35 * math.sin(ratio * math.pi * 0.8))
    draw.line([(0, y), (SIZE, y)], fill=(r, g, b))

cx, cy = SIZE // 2, SIZE // 2

# Concentric portal rings with varying opacity
ring_colors = [
    (20, 60, 140),   # deep blue
    (30, 80, 180),   # medium blue
    (50, 120, 200),  # lighter blue
    (40, 170, 210),  # cyan
    (60, 200, 180),  # teal
]

for i, color in enumerate(ring_colors):
    radius = 420 - i * 60
    width = 2 if i % 2 == 0 else 1
    draw.ellipse([cx-radius, cy-radius, cx+radius, cy+radius], outline=color, width=width)

# Vesica Piscis (two overlapping circles forming eye shape)
eye_w = 340
eye_h = 200
# Upper arc
for t in range(360):
    angle = math.radians(t)
    x = cx + eye_w * math.cos(angle)
    y = cy - 80 + eye_h * 1.8 * math.sin(angle)
    if cy - 80 + eye_h * 1.8 * math.sin(angle) < cy + 30 and t < 180:
        pass  # skip

# Draw the eye shape with arcs
points_upper = []
points_lower = []
for t in range(100):
    frac = t / 99.0
    angle = -math.pi + frac * 2 * math.pi
    # Upper lid
    x = cx + 300 * math.cos(angle)
    y = cy - 160 * math.sin(angle) * math.sin(angle) - 20
    points_upper.append((x, y))
    # Lower lid
    y2 = cy + 160 * math.sin(angle) * math.sin(angle) + 20
    points_lower.append((x, y2))

# Draw eye outline
cyan = (50, 190, 230)
for i in range(len(points_upper) - 1):
    draw.line([points_upper[i], points_upper[i+1]], fill=cyan, width=2)
    draw.line([points_lower[i], points_lower[i+1]], fill=cyan, width=2)

# Inner eye (iris) - multiple rings
for r in range(180, 0, -3):
    ratio = r / 180.0
    c = (
        int(10 + 40 * (1 - ratio)),
        int(20 + 100 * (1 - ratio) * ratio),
        int(60 + 170 * (1 - ratio))
    )
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], outline=c, width=1)

# Pupil - bright center portal
for r in range(80, 0, -1):
    ratio = r / 80.0
    c = (
        int(100 + 155 * (1 - ratio)),
        int(200 + 55 * (1 - ratio)),
        int(255)
    )
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=c)

# Inner bright core
for r in range(30, 0, -1):
    ratio = r / 30.0
    c = (
        int(200 + 55 * (1 - ratio)),
        int(230 + 25 * (1 - ratio)),
        255
    )
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=c)

# Sacred geometry - rotating triangles around the eye
for layer in range(3):
    n_points = 7 + layer * 5
    radius = 250 + layer * 70
    rot_offset = layer * 15
    color = (
        30 + layer * 15,
        80 + layer * 30,
        180 - layer * 20
    )
    for i in range(n_points):
        angle1 = math.radians(rot_offset + i * 360 / n_points)
        angle2 = math.radians(rot_offset + (i + 1) * 360 / n_points)
        x1 = cx + radius * math.cos(angle1)
        y1 = cy + radius * math.sin(angle1)
        x2 = cx + radius * math.cos(angle2)
        y2 = cy + radius * math.sin(angle2)
        draw.line([(x1, y1), (x2, y2)], fill=color, width=1)
        # Radial lines to center ring
        inner_r = radius - 60
        x3 = cx + inner_r * math.cos(angle1)
        y3 = cy + inner_r * math.sin(angle1)
        draw.line([(x1, y1), (x3, y3)], fill=(color[0]//2, color[1]//2, color[2]//2), width=1)

# Scattered light particles
for _ in range(40):
    px = random.randint(100, SIZE - 100)
    py = random.randint(100, SIZE - 100)
    dist = math.sqrt((px - cx)**2 + (py - cy)**2)
    if dist > 200:
        size = random.randint(1, 3)
        brightness = random.randint(150, 255)
        draw.ellipse([px, py, px+size, py+size], fill=(brightness, brightness, int(brightness * 0.95)))

# Ray beams from center
for i in range(12):
    angle = math.radians(i * 30 + 15)
    length = random.randint(350, 450)
    x_end = cx + length * math.cos(angle)
    y_end = cy + length * math.sin(angle)
    for w in range(3, 0, -1):
        alpha_color = (
            20 + (3-w) * 10,
            60 + (3-w) * 30,
            150 + (3-w) * 30
        )
        draw.line([(cx, cy), (x_end, y_end)], fill=alpha_color, width=w)

# Re-draw the bright center on top
for r in range(60, 0, -1):
    ratio = r / 60.0
    c = (
        int(80 + 175 * (1 - ratio)),
        int(180 + 75 * (1 - ratio)),
        255
    )
    draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=c)

# Slight blur for glow effect
img = img.filter(ImageFilter.GaussianBlur(radius=1))

# Re-sharpen center
draw2 = ImageDraw.Draw(img)
for r in range(25, 0, -1):
    ratio = r / 25.0
    c = (
        int(200 + 55 * (1 - ratio)),
        int(235 + 20 * (1 - ratio)),
        255
    )
    draw2.ellipse([cx-r, cy-r, cx+r, cy+r], fill=c)

import os
output = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "EnochianKeys", "Assets.xcassets", "AppIcon.appiconset", "icon_1024.png")
img.save(output, "PNG")
print(f"Icon saved: {output}")
img.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), "AppIcon.png"), "PNG")
print("Done - Portal Eye icon")
