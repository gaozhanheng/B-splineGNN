# B-splineGNN: unsupervised graph neural network for fitting B-spline curve to planar data points

## 创新：
1、一次训练，随时推断。真正的用ai框架解决曲线拟合问题

2、泛华性能很强：用trainset训练的模型（30epochs，30data files），经过4次左右的epoch，拟合精度能达到0.0014左右（z-score规范化，MSE）。且不仅对testset中的数据具有很高的拟合精度（0.0002甚至更小），而且，对于没见过的数据集（Flipped1070，kitchen，manifold，UIUC airfoil），拟合精度不遑多让。尤其是：UIUC airfoil其实是机翼剖面曲线，训练的时候根本没见过。竟然也能有如此高的拟合，不得不佩服人工智能技术的神奇。

3、对于输入数据点的个数没有限制。（输出控制顶点是30个，将来考虑是否也能自适应）

## 文件列表：
1. BSplineGNN-V1.2.3.ipynb: 程序文件
2. BSplineGNN-V1.2.2.html ，BSplineGNN-V1.2.3.html：分别是两个版本的代码在训练、测试之后导出的html，目的是将当时的计算结果固定下来。
3. saved_model/best_model.pth:用pytorch训练出来的模型。模型是在AutoDL上训练出来的（原本想对441个数据文件训练100epoch，然而，训练到21epoch的时候就断了。效果已经挺好的了）。文件中不仅包含模型参数，还包含一些配置信息，训练收敛效果等数据。该模型实际上是用v1.2实现的。虽然在内容上有差异，但用v1.2.2和v1.2.3都可以进行载入、推断。
4. trainhistory.txt: 训练的时候的每轮的mse的值，用来显示收敛速度
5. pred loss.txt: 训练的时候测试的结果。
6. data：包含用于训练的数据（dataset/v2）和大量用于测试的数据集（其他）。

## 用法：
打开ipynb文件，一个cell一个cell执行即可。
会把data中一些指定的文件夹中的内容预测出来，单独存成一些特定名称的文件夹中。
