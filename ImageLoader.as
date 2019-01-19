/***********************************************************************
		*	模块功能：图片加载		*
		*	作者：易 名				*
		*	时间：2019-01-08			*
***********************************************************************/



package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class ImageLoader extends Sprite
	{
		//定义loader对象和图片的尺寸（宽高）
		private var loader:Loader;
		private var _img_x:int;
		private var _img_y:int;

		//定义构造函数
		public function ImageLoader(img_x:int, img_y:int, url:String)
		{
			_img_x = img_x;
			_img_y = img_y;

			loader = new Loader();

			//给loader创建侦听器
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete_handler);
			
			//载入图片到loader
			loader.load(new URLRequest(url));

		}

		//图片成功载入函数处理，并设置图片的坐标
		private function complete_handler(e:Event):void
		{
			var loader:Loader = Loader(e.target.loader);
			var bitmap:Bitmap = Bitmap(loader.content);

			bitmap.x = _img_x;
			bitmap.y = _img_y;
			
			//将bitmap 加入到ImageLoader
			this.addChild(bitmap);
		}
	}
}