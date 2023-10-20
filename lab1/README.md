# Lab 1

## 實驗目標

- 七段顯示器解碼電路 (0~F)
- 七段顯示器解碼電路 (000~FFF)

## 實驗目的

- 學習七段顯示器的解碼過程
- 練習如何以 VHDL 邏輯函數方式實現邏輯電路
- 配合實作熟悉硬體電路架構與配置部分

## 基本概念

七段顯示器共有 a, b, c, d, e, f, g 七段用來顯示數字 0~9 及一點 p 來顯示小數點。
七段顯示器有分共陽極與共陰極，共陽極表示七段共同接到高電位，如果想要發亮，需要給它低電位；共陰極則相反。

## 電路設計

### 七段顯示器解碼電路 (0~F)

該 FPGA 板的七段顯示器為共陽極，根據該特性，建立下方真值表。

<table>
<thead>
   <tr>
      <th>數字</th>
      <th>W</th>
      <th>X</th>
      <th>Y</th>
      <th>Z</th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
      <th>e</th>
      <th>f</th>
      <th>g</th>
   <tr>
</thead>
<tbody>
   <tr>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
   </tr>
   <tr>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
   </tr>
   <tr>
      <td>2</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
   </tr>
   <tr>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
   </tr>
   <tr>
      <td>4</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>5</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>6</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>7</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
   </tr>
   <tr>
      <td>8</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>9</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>A</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>B</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>C</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
   </tr>
   <tr>
      <td>D</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
   </tr>
   <tr>
      <td>E</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
   <tr>
      <td>F</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
   </tr>
</tbody>

化簡 a~g 輸出布林代數:<br>

$a=f(W,X,Y,Z)=\sum\{1,4,11,12,13\}$<br>
$b=f(W,X,Y,Z)=\sum\{5,6,11,12,14,15\}$<br>
$c=\bar{W}\bar{X}Y\bar{Z}+YZ\bar{Z}+WXY$<br>
$d=\bar{X}\bar{Y}Z+\bar{W}X\bar{Y}\bar{Z}+XYZ+W\bar{X}Y\bar{Z}$<br>
$e=\bar{W}Z+\bar{W}X\bar{Y}+\bar{X}\bar{Y}Z$<br>
$f=\bar{W}\bar{X}Z+\bar{W}\bar{X}Y+\bar{W}YZ+WX\bar{Y}$<br>
$g=\bar{W}\bar{X}\bar{Y}+\bar{W}XYZ$

### 七段顯示器解碼電路 (000~FFF)

使用 3 組上方的邏輯電路拼接組成。
