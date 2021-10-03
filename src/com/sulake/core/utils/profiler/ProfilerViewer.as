package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IProfiler;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ProfilerViewer extends TextField implements IDisposable
   {
       
      
      protected var _disposed:Boolean = false;
      
      public function ProfilerViewer()
      {
         var _loc1_:TextFormat = new TextFormat("Courier New",8);
         defaultTextFormat = _loc1_;
         setTextFormat(_loc1_);
         textColor = 16777215;
         width = 10;
         height = 10;
         autoSize = "left";
         mouseEnabled = false;
         selectable = false;
         super();
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
      
      private function recursiveUpdate(param1:ProfilerAgentTask, param2:uint) : void
      {
         text += padAlign(String(param1.name),30) + "|" + padAlign(String(param1.rounds),10) + "|" + padAlign(String(param1.latest),10) + "|" + padAlign(String(param1.average),10) + "|" + padAlign(String(param1.total),10) + "|\r";
         var _loc3_:int = 0;
         while(_loc3_ < param1.numSubTasks)
         {
            recursiveUpdate(param1.getSubTaskAt(_loc3_),param2 + 1);
            _loc3_++;
         }
      }
      
      public function refresh(param1:IProfiler) : void
      {
         text = padAlign("task",30) + "|" + padAlign("#rounds",10," ",true) + "|" + padAlign("latest ms",10," ",true) + "|" + padAlign("average ms",10," ",true) + "|" + padAlign("total ms",10," ",true) + "|\r" + padAlign("",30,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|\r";
         var _loc2_:Array = param1.getProfilerAgentsInArray();
         while(_loc2_.length > 0)
         {
            recursiveUpdate(_loc2_.pop(),0);
         }
         if(parent)
         {
            parent.swapChildren(this,parent.getChildAt(-1));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(parent != null)
            {
               parent.removeChild(this);
            }
            _disposed = true;
         }
      }
   }
}
