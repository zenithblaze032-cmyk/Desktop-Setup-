; =============================================================
; COMBINED VARIABLES.INC — MASTER COMBO SUITE
; Contains Samurai and Spiderman specific variables and 
; includes the active theme for the Iron Man suite.
; =============================================================

[Variables]
Scale=1.0
ScrollMouseIncrement=0.05
Format=%I:%M
Format24=%H:%M
Hidden=0

; =============================================================
; 1. SAMURAI / MONOCHROME PALETTE
; =============================================================
Color1=20,20,22,255
Color2=70,70,78,255
Color3=130,130,138,255

ColorDeep=8,8,8,255
ColorRich=15,15,15,255
ColorMid=24,24,24,255

TextGradLight=45,45,50,255
ShadowDeep=0,0,0,80
ShadowAura=0,0,0,40
CrimsonBright=200,20,20,255
LineColorLight=200,200,205,20
LineColor=150,150,155,90

ShadowColor=0,0,0,18
CrimsonAccent=150,8,8,255
CrimsonSoft=150,8,8,130
KanjiGhost=16,16,16,16

; =============================================================
; 2. SPIDERMAN SUITE PALETTE
; =============================================================
ThemeRed=136,39,56,255
ThemeBlack=27,46,64,255
ThemeGray=173,177,186,255
ThemeWatermark=27,46,64,80
ThemeShadow=27,46,64,100

ThemeRedGlow=136,39,56,150
ThemeBlackGlow=27,46,64,150
ThemeRedBright=200,50,70,255
ThemeBlackLight=50,75,100,255

; =============================================================
; 3. IRON MAN SUITE PALETTES
; Active theme variables import
; =============================================================
@includeTheme=#@#Variables_1A_Blueprint.inc
