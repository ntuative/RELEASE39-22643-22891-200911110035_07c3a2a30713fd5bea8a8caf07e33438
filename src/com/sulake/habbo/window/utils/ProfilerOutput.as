package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IProfiler;
   import com.sulake.core.utils.profiler.ProfilerAgentTask;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ICanvasWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class ProfilerOutput implements IDisposable
   {
      
      public static var habbo_profiler_task_xml:Class = ProfilerOutput_habbo_profiler_task_xml;
      
      public static var habbo_profiler_dialog_xml:Class = ProfilerOutput_habbo_profiler_dialog_xml;
       
      
      private var _disposed:Boolean = false;
      
      private var var_987:Boolean = false;
      
      private var _window:IFrameWindow;
      
      private var var_605:IWindowRenderer;
      
      private var var_345:IProfiler;
      
      private var var_2055:Array;
      
      private var _windowManager:IHabboWindowManager;
      
      public function ProfilerOutput(param1:IProfiler, param2:IHabboWindowManager, param3:IWindowRenderer)
      {
         super();
         var_2055 = new Array();
         var_345 = param1;
         _windowManager = param2;
         var_605 = param3;
         var _loc4_:ByteArray = new habbo_profiler_dialog_xml() as ByteArray;
         var _loc5_:XML = new XML(_loc4_.readUTFBytes(_loc4_.length));
         _window = _windowManager.buildFromXML(_loc5_,2) as IFrameWindow;
         _window.procedure = profilerWindowEventProc;
         var_345.addStopEventListener(refresh);
         ITextWindow(_window.findChildByName("header")).text = padAlign("task",28) + "|" + padAlign("#rounds",8) + "|" + padAlign("latest ms",8) + "|" + padAlign("average ms",10) + "|" + padAlign("total ms",8) + "|";
         ITextWindow(_window.findChildByName("footer")).text = "<- Click to enable bitmap memory tracking";
         ITextWindow(_window.findChildByName("footer")).textColor = 4284900966;
      }
      
      private static function padAlign(param1:String, param2:int, param3:String = " ", param4:Boolean = false) : String
      {
         var _loc5_:int = param2 - param1.length;
         if(_loc5_ <= 0)
         {
            return param1.substring(0,param2);
         }
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ += param3;
            _loc7_++;
         }
         return !!param4 ? _loc6_ + param1 : param1 + _loc6_;
      }
      
      private function refreshCanvasImage(param1:ICanvasWindow, param2:ProfilerAgentTask) : void
      {
         var _loc3_:Rectangle = new Rectangle();
         var _loc4_:BitmapData = param1.retrieveDrawBuffer(null,_loc3_);
         _loc3_.x += 1;
         --_loc3_.width;
         _loc4_.copyPixels(_loc4_,_loc3_,new Point());
         _loc3_.x += _loc3_.width - 2;
         _loc3_.y += _loc3_.height - param2.latest;
         _loc3_.width = 1;
         _loc3_.height = param2.latest;
         _loc4_.fillRect(_loc3_,4278190335);
         param1.invalidate();
      }
      
      private function recursiveRedraw(param1:ProfilerAgentTask, param2:IItemListWindow, param3:uint, param4:uint) : uint
      {
         var _loc5_:* = null;
         if(param3 >= param2.numListItems)
         {
            _loc5_ = createListItem(param2);
         }
         else
         {
            _loc5_ = param2.getListItemAt(param3) as IWindowContainer;
         }
         var _loc6_:String = param1.name;
         if(param4 > 0)
         {
            _loc6_ = padAlign(_loc6_,param4 + _loc6_.length,"-",true);
         }
         var _loc7_:ITextWindow = _loc5_.findChildByName("text") as ITextWindow;
         _loc7_.text = padAlign(_loc6_,28," ",false) + "|" + padAlign(String(param1.rounds),8," ",true) + "|" + padAlign(String(param1.latest),8," ",true) + "|" + padAlign(String(param1.average),10," ",true) + "|" + padAlign(String(param1.total),8," ",true) + "|\r";
         ITextWindow(_loc5_.findChildByName("caption")).text = param1.caption;
         var _loc8_:IBitmapWrapperWindow = _loc5_.findChildByName("canvas") as IBitmapWrapperWindow;
         refreshBitmapImage(_loc8_,param1);
         param3++;
         var _loc9_:int = 0;
         while(_loc9_ < param1.numSubTasks)
         {
            param3 = recursiveRedraw(param1.getSubTaskAt(_loc9_),param2,param3,param4 + 1);
            _loc9_++;
         }
         return param3;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function refreshBitmapImage(param1:IBitmapWrapperWindow, param2:ProfilerAgentTask) : void
      {
         var _loc3_:BitmapData = param1.bitmap;
         if(_loc3_ == null)
         {
            _loc3_ = new BitmapData(param1.width,param1.height,false,4294967295);
            param1.bitmap = _loc3_;
         }
         var _loc4_:Rectangle = _loc3_.rect;
         _loc4_.x += 1;
         --_loc4_.width;
         _loc3_.copyPixels(_loc3_,_loc4_,new Point());
         _loc4_.x += _loc4_.width - 2;
         _loc4_.y += _loc4_.height - param2.latest;
         _loc4_.width = 1;
         _loc4_.height = param2.latest;
         _loc3_.fillRect(_loc4_,4278190335);
         param1.invalidate();
      }
      
      private function createListItem(param1:IItemListWindow) : IWindowContainer
      {
         var _loc2_:ByteArray = new habbo_profiler_task_xml() as ByteArray;
         var _loc3_:XML = new XML(_loc2_.readUTFBytes(_loc2_.length));
         var _loc4_:IWindowContainer = _windowManager.buildFromXML(_loc3_,2) as IWindowContainer;
         param1.addListItem(_loc4_);
         return _loc4_;
      }
      
      private function profilerWindowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(param2.tags.indexOf("close") > -1)
            {
               dispose();
            }
            else if(param2.name == "button_gc")
            {
               var_345.gc();
            }
         }
         if(param2.name == "footer_enable_toggle")
         {
            if(param1.type == WindowEvent.const_51)
            {
               var_987 = true;
               ITextWindow(_window.findChildByName("footer")).textColor = 4278190080;
            }
            else if(param1.type == WindowEvent.const_679)
            {
               var_987 = false;
               ITextWindow(_window.findChildByName("footer")).textColor = 4284900966;
            }
         }
      }
      
      public function refresh(param1:Event) : void
      {
         var _loc2_:Array = var_345.getProfilerAgentsInArray();
         var _loc3_:IItemListWindow = _window.findChildByName("list") as IItemListWindow;
         var _loc4_:uint = _loc3_.numListItems;
         var _loc5_:* = 0;
         while(_loc2_.length > 0)
         {
            _loc5_ = uint(recursiveRedraw(_loc2_.pop(),_loc3_,_loc5_,0));
         }
         if(var_987)
         {
            ITextWindow(_window.findChildByName("footer")).text = "Assets - Libraries: undefined Bitmaps: undefined / undefined bytes \nWindows - Allocated bitmap data: NaN bytes";
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _window.dispose();
            _window = null;
            var_345.removeStopEventListener(refresh);
            var_345 = null;
            _windowManager = null;
            var_605 = null;
            _disposed = true;
         }
      }
   }
}
