package
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.tracking.HabboLoginTrackingStep;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.getDefinitionByName;
   import utils.LoadingScreen;
   import utils.LoadingScreenListener;
   
   public class Habbo extends MovieClip implements IDisposable, LoadingScreenListener
   {
      
      private static const const_3:Number = 0.29;
      
      private static const const_2:Number = 0.71;
       
      
      private var _disposed:Boolean;
      
      private var var_4:LoadingScreen;
      
      private var var_9:Boolean;
      
      private var var_10:IHabboMain;
      
      private var var_1:Loader;
      
      public function Habbo()
      {
         super();
         stop();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.quality = StageQuality.LOW;
         stage.align = StageAlign.TOP_LEFT;
         trackLoginStep(HabboLoginTrackingStep.const_8);
         _disposed = false;
         var_9 = false;
         var_4 = new LoadingScreen(const_2,this);
         addChild(var_4);
         root.loaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadingProgress);
         root.loaderInfo.addEventListener(Event.COMPLETE,onLoadingCompleted);
         var_1 = new Loader();
         loadVolter();
         root.addEventListener(Event.ENTER_FRAME,onEnterFrame);
      }
      
      private function trackLoginStep(param1:String) : void
      {
         if(stage == null)
         {
            return;
         }
         if(stage.loaderInfo.parameters["processlog.enabled"] != "1")
         {
            return;
         }
         Logger.log("* Habbo Login Step: " + param1);
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
         }
         else
         {
            Logger.log("Habbo: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      public function onFadingAnimationComplete() : void
      {
         if(var_10 != null)
         {
            root.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            var_10.initializeCore();
            this.dispose();
         }
      }
      
      private function onVolterLoadingFailedAgain(param1:Event) : void
      {
         Logger.log("Volter loading failed again - giving up");
         trackLoginStep(HabboLoginTrackingStep.const_6);
         if(var_1 != null)
         {
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailedAgain);
            var_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,onVolterLoadingCompleted);
         }
         checkLoadingStatus();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function initHabbo() : void
      {
         var _loc1_:Class = Class(getDefinitionByName("HabboMain"));
         if(_loc1_)
         {
            var_10 = new _loc1_(var_4);
            addChild(var_10 as DisplayObject);
         }
      }
      
      private function onLoadingProgress(param1:Event) : void
      {
         var _loc2_:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal * const_3;
         if(var_4 != null)
         {
            var_4.updateLoadingBar(_loc2_);
         }
      }
      
      private function checkLoadingStatus() : void
      {
         Logger.log("Checking loading status");
         if(!var_9)
         {
            if(root.loaderInfo.bytesLoaded == root.loaderInfo.bytesTotal)
            {
               onLoadingCompleted(null);
            }
         }
      }
      
      private function onLoadingCompleted(param1:Event) : void
      {
         if(!var_9)
         {
            var_9 = true;
            Logger.log("Habbo loading completed");
            trackLoginStep(HabboLoginTrackingStep.const_7);
            root.loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadingProgress);
            root.loaderInfo.removeEventListener(Event.COMPLETE,onLoadingCompleted);
            nextFrame();
            initHabbo();
         }
      }
      
      private function onVolterLoadingFailed(param1:Event) : void
      {
         Logger.log("Volter loading failed - retrying");
         trackLoginStep(HabboLoginTrackingStep.const_5);
         if(var_1 != null)
         {
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailed);
            var_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,onVolterLoadingCompleted);
         }
         loadVolter(true);
      }
      
      private function loadVolter(param1:Boolean = false) : void
      {
         var _loc2_:String = "Volter.swf";
         if(param1)
         {
            _loc2_ = _loc2_ + "?" + new Date().getTime();
            if(var_1 != null)
            {
               var_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailedAgain);
            }
         }
         else if(var_1 != null)
         {
            var_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailed);
         }
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         if(var_1 != null)
         {
            var_1.contentLoaderInfo.addEventListener(Event.COMPLETE,onVolterLoadingCompleted);
            var_1.load(new URLRequest(_loc2_),_loc3_);
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            removeChild(var_4);
            var_4.dispose();
            var_4 = null;
            var_1 = null;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         parent.setChildIndex(this,-1);
      }
      
      private function onVolterLoadingCompleted(param1:Event) : void
      {
         Logger.log("Volter loading completed");
         trackLoginStep(HabboLoginTrackingStep.const_4);
         if(var_1 != null)
         {
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailed);
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onVolterLoadingFailedAgain);
            var_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,onVolterLoadingCompleted);
         }
         if(var_4 != null)
         {
            var_4.updateFont("Volter",true);
         }
         checkLoadingStatus();
      }
   }
}
