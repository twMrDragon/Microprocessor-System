# Lab 2

## 實驗目標

- 多位元加法器設計
- 多位元減法器設計

## 實驗目的

- 熟悉 Package 與 Component
- 使用 Package 與 Component 完成 1 位元全加器
- 使用 1 位元全加器完成 8 位元全加器
- 使用 1 位元全加器完成 8 位元全減器

## 基本概念

組合邏輯電路(Conbinaation Logic Circuit)主要在於它的輸出只受輸入函數的控制，而不受先前輸入及狀態記憶影響。

## 電路設計

### 多位元加法器設計

根據 1 位元全加器真值表設計邏輯電路。

<table>
   <thead>
      <tr>
         <th colspan=3>輸入</th>
         <th colspan=2>輸出</th>
      </tr>
      <tr>
         <th>cin</th>
         <th>a</th>
         <th>b</th>
         <th>cout</th>
         <th>s</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>0</td>
         <td>0</td>
         <td>0</td>
         <td>0</td>
         <td>0</td>
      </tr>
      <tr>
         <td>0</td>
         <td>0</td>
         <td>1</td>
         <td>0</td>
         <td>1</td>
      </tr>
      <tr>
         <td>0</td>
         <td>1</td>
         <td>0</td>
         <td>0</td>
         <td>1</td>
      </tr>
      <tr>
         <td>0</td>
         <td>1</td>
         <td>1</td>
         <td>1</td>
         <td>0</td>
      </tr>
      <tr>
         <td>1</td>
         <td>0</td>
         <td>0</td>
         <td>0</td>
         <td>1</td>
      </tr>
      <tr>
         <td>1</td>
         <td>0</td>
         <td>1</td>
         <td>1</td>
         <td>0</td>
      </tr>
      <tr>
         <td>1</td>
         <td>1</td>
         <td>0</td>
         <td>1</td>
         <td>0</td>
      </tr>
      <tr>
         <td>1</td>
         <td>1</td>
         <td>1</td>
         <td>1</td>
         <td>1</td>
      </tr>
   </tbody>
</table>

布林化簡後:<br>
$s_i=x_i\oplus{y_i}\oplus{cin_i}$<br>
$c_{i+1}=x_iy_i+x_ic_i+y_ic_i$

接著使用 Component 把 8 個位元全加器建構出 8 位元全加器。

### 多位元減法器設計

使用上方的邏輯電路，並把其中一項輸入使用 2 的補數轉換成負數。
