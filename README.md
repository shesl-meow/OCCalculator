# Calculator

在学习 Objective-C 时的第一个项目。

## 代码规范更改记录

property nonatomic 补全：

- 正则替换：`(@property)\(([a-zA-Z]*), nonatomic\)` ➡️ `$1(nonatomic, $2)`

- 正则替换：`(@property)\(([a-zA-Z]*)\)` ➡️ `$1(nonatomic, $2)`

函数花括号换行：

- 正则替换：`^([+-] .*)\{$` ➡️ `$1\n{`

property 声明在 func 前面：

- 重复正则替换直到结束：`(^[+-] .*;[\n]+)(^@property\(.*?\).*?;$[\n]+)` ➡️ `$2$1`

声明 前后 空行：

- 正则替换属性后空行：`(@property\(.*?\).*?;)\n([^\n])` ➡️ `$1\n\n$2`

- 正则替换函数后空行：`(^[+-].*?;)\n([^\n])` ➡️ `$1\n\n$2`

~~enum 定义在 interface 上面~~

~~init  函数写法  尽量不要用 self.property 访问 /  if  self~~

~~switch case `Caculator/NormalCalculator/NormalLogic.m`~~

~~operator 空格~~

~~func 命名  小写~~

~~enum 命名问题~~

