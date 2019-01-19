/***********************************************************************
		*	模块功能：地 图			*
		*	作者：易 名				*
		*	时间：2019-01-08			*
***********************************************************************/


package 
{
	import flash.display.Sprite;

	public class Map extends Sprite
	{
		//定义Map的构造函数
		public function Map()
		{
			draw_map();
		}

		//绘制地图
		private function draw_map():void
		{
			//矩形的坐标
			var rec_x:int = 86;
			var rec_y:int = 200;

			//矩形的宽高
			var rec_width:int = 140;
			var rec_height:int = 140;


			//定义容器对象
			var rec_container:Sprite = new Sprite();


			//绘制9个矩形，3行3列
			for (var i:int = 0; i < 9; i++)
			{
				//控制每行3个矩形
				if(rec_x > 500)
				{
					rec_x = 86
					rec_y += 147;
				}
				
				//定义Sprite对象，画矩形
				var rec:Sprite = new Sprite();
				rec.graphics.beginFill(0xD9BF9A);
				rec.graphics.drawRect(rec_x, rec_y, rec_width, rec_height);
				rec.graphics.endFill();
				
				//将生成的每个矩形对象添加到容器
				rec_container.addChild(rec);
				
				//每个矩形间距为7像素
				rec_x += 147;
			}
			
			//讲对象容器加入到舞台
			addChild(rec_container);
		}
	}

}