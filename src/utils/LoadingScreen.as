package utils
{
   import com.sulake.core.runtime.ICoreConfigStatusListener;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class LoadingScreen extends Sprite implements ICoreConfigStatusListener
   {
      
      private static const const_1:String = "client.starting";
       
      
      private var _disposed:Boolean;
      
      private var var_12:String;
      
      private var var_5:Background;
      
      private var var_2:TextField;
      
      private var var_7:LoadingBar;
      
      private var var_16:Class;
      
      private var var_11:Boolean;
      
      private var var_14:LoadingScreenListener;
      
      private var var_8:Bitmap;
      
      private var var_15:Number;
      
      public function LoadingScreen(param1:Number = 1, param2:LoadingScreenListener = null)
      {
         var_16 = LoadingScreen_habboLogoClass;
         super();
         var_12 = const_1;
         var_15 = param1;
         var_14 = param2;
         _disposed = false;
         var_11 = false;
         addEventListener(Event.ADDED_TO_STAGE,onStageInit);
      }
      
      private function onResize(param1:Event) : void
      {
         if(param1.type == Event.RESIZE)
         {
            positionDisplayElements();
         }
      }
      
      private function startFadingAnimation() : void
      {
         if(!var_11)
         {
            var_11 = true;
            if(true)
            {
               var_2.visible = false;
            }
            addEventListener(Event.ENTER_FRAME,onEnterFrame);
         }
      }
      
      private function onStageInit(param1:Event = null) : void
      {
         if(stage.loaderInfo.parameters[const_1] != null)
         {
            var_12 = stage.loaderInfo.parameters[const_1];
         }
         var_5 = new Background(0);
         addChild(var_5);
         var_8 = new var_16();
         addChild(var_8);
         var_2 = new TextField();
         var_2.text = var_12;
         var_2.autoSize = TextFieldAutoSize.LEFT;
         addChild(var_2);
         updateFont("Verdana");
         var_7 = new LoadingBar();
         addChild(var_7);
         stage.addEventListener(Event.RESIZE,onResize);
         positionDisplayElements();
      }
      
      public function set percent(param1:Number) : void
      {
         var _loc2_:Number = 1 - var_15 + param1 * var_15;
         var_7.percent = _loc2_;
         if(var_5 != null)
         {
            var_5.alpha = 1 - _loc2_;
         }
         if(param1 == 1)
         {
            startFadingAnimation();
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            if(var_5 != null)
            {
               removeChild(var_5);
               var_5 = null;
            }
            removeChild(var_2);
            var_2 = null;
            removeChild(var_7);
            var_7.dispose();
         }
      }
      
      public function updateLoadingBar(param1:Number) : void
      {
         var_7.percent = param1;
      }
      
      private function positionTextField() : void
      {
         if(disposed)
         {
            return;
         }
         var_2.x = 191;
         var_2.y = NaN;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function positionDisplayElements() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_5 != null)
         {
            var_5.x = 0;
            var_5.y = 0;
         }
         var_8.x = 117;
         var_8.y = 57;
         positionTextField();
         var_7.x = 89;
         var_7.y = 149;
      }
      
      public function updateFont(param1:String, param2:Boolean = false) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:TextFormat = new TextFormat();
         _loc3_ = new TextFormat();
         _loc3_.font = param1;
         _loc3_.color = 16777215;
         _loc3_.size = 9;
         var_2.defaultTextFormat = _loc3_;
         var_2.embedFonts = param2;
         var_2.text = var_2.text;
         positionTextField();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(alpha == 0)
         {
            removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            if(var_14 != null)
            {
               var_14.onFadingAnimationComplete();
            }
         }
         alpha -= 0.1;
         if(alpha < 0)
         {
            alpha = 0;
         }
      }
   }
}
