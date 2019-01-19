/***********************************************************************
*模块功能：游戏主程序*
*作者：易 名*
*时间：2019-01-08*
***********************************************************************/

package 
{

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	public class PokeAMole extends MovieClip
	{
		var game_over:Boolean = false;

		//定义背景音乐对象和通道
		var bgm:Sound = new Sound  ;
		var bgm_channel = new SoundChannel  ;

		//定义老鼠惨叫音乐对象和通道
		var lscj:Sound = new Sound  ;
		var lscj_channel = new SoundChannel  ;

		//定义游戏结束时的音乐对象和通道
		var over_music:Sound = new Sound  ;
		var over_music_channel = new SoundChannel  ;

		//定时器：定义地鼠出现间隔为800毫秒,出现次数为50次
		private var level:int = 800;
		private var times:int = 50;
		private var timer:Timer = new Timer(level,times);

		//定义得分变量
		private var score:int = 0;
		private var score_label:TextField = new TextField  ;

		//定义游戏名标签
		private var game_name:TextField = new TextField  ;

		public function PokeAMole()
		{
			//载入地图
			load_map();

			//载入bgm
			load_music("music/bgm.mp3");

			//载入老鼠惨叫声
			lscj.load(new URLRequest("music/lscj.mp3"));

			//载入游戏结束声音
			over_music.load(new URLRequest("music/over.mp3"));

			//开启定时器，在9宫格中随机出现一直地鼠;
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,rand_ds);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,finished_timer);
			
			//加载游戏名
			load_name();
		}

		//加载游戏名
		private function load_name():void
		{
			game_name.text = "打地鼠";
			game_name.x = 165;
			game_name.y = 75;
			game_name.autoSize = TextFieldAutoSize.LEFT;
			var tf:TextFormat = new TextFormat();
			tf.size = 85;
			tf.color = 0x000000;
			tf.font = "黑体";
			game_name.setTextFormat(tf);
			addChild(game_name);
		}

		//载入音乐
		private function load_music(music:String):void
		{
			bgm.load(new URLRequest(music));
			bgm_channel = bgm.play();

		}

		//定时器结束后的操作（显示最终分数并载入游戏结束音乐）
		private function finished_timer(evt:Event):void
		{
			bgm_channel.stop();
			over_music_channel = over_music.play();
			score_label.text = "最终得分:" + score;
			score_label.x = 75;
			score_label.y = 75;
			score_label.autoSize = TextFieldAutoSize.LEFT;
			var tf:TextFormat = new TextFormat  ;
			tf.size = 70;
			tf.color = 0x000000;
			tf.font = "黑体";
			score_label.setTextFormat(tf);
			addChild(score_label);
		}

		//加载地图行函数
		private function load_map():void
		{
			var map:Map = new Map  ;
			addChild(map);
		}

		//随机老鼠
		private function rand_ds(event:TimerEvent):void
		{
			//随机出现一个位于任一一个格子里的地鼠
			var x_array:Array = [85,230,375];
			var y_array:Array = [195,340,485];
			var ds_x:int = x_array[Math.floor(Math.random() * x_array.length)];
			var ds_y:int = y_array[Math.floor(Math.random() * y_array.length)];
			var ds:ImageLoader = new ImageLoader(ds_x,ds_y,"images/ds.png");
			addChild(ds);

			//鼠标点击到地鼠就提升难度
			ds.addEventListener(MouseEvent.CLICK,hit_ds);

			//如果格子里的地鼠数量大于2就清空容器
			if (this.numChildren > 2)
			{
				for (var i:int = this.numChildren - 1; i > 0; i--)
				{
					this.removeChildAt(i);
				}
			}
		}

		//打中地鼠后的操作
		private function hit_ds(evt:Event):void
		{
			//播放老鼠惨叫声
			lscj_channel = lscj.play();

			//刷新实时得分;
			score +=  50;
			score_label.text = "目前得分：" + score;
			score_label.x = 75;
			score_label.y = 75;
			score_label.autoSize = TextFieldAutoSize.LEFT;
			var tf:TextFormat = new TextFormat  ;
			tf.size = 70;
			tf.color = 0x000000;
			tf.font = "黑体";
			score_label.setTextFormat(tf);
			addChild(score_label);

			//设置难度最低限度（300毫秒）
			if ((level >= 300))
			{
				level -=  50;
			}

			//重置难度
			timer.delay = level;
		}

	}

}