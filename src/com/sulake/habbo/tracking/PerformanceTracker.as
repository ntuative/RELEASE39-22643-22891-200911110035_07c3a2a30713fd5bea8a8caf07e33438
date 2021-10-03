package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.debug.GarbageMonitor;
   import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   
   public class PerformanceTracker
   {
       
      
      private var var_2081:Array;
      
      private var var_1379:GarbageMonitor = null;
      
      private var var_918:int = 0;
      
      private var var_1134:int = 0;
      
      private var var_1174:Boolean = false;
      
      private var _connection:IConnection = null;
      
      private var var_1863:String = "";
      
      private var var_917:int = 0;
      
      private var var_1925:String = "";
      
      private var var_1861:String = "";
      
      private var var_509:Number = 0;
      
      private var var_1135:int = 10;
      
      private var var_1132:int = 1000;
      
      private var var_160:IHabboConfigurationManager = null;
      
      private var var_1862:String = "";
      
      private var var_1380:int = 0;
      
      private var var_548:int = 0;
      
      private var var_1133:int = 60;
      
      public function PerformanceTracker()
      {
         var_2081 = [];
         super();
         var_1861 = Capabilities.version;
         var_1863 = Capabilities.os;
         var_1174 = Capabilities.isDebugger;
         var_1862 = !true ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
         var_1379 = new GarbageMonitor();
         updateGarbageMonitor();
         var_1134 = getTimer();
      }
      
      public function set connection(param1:IConnection) : void
      {
         _connection = param1;
      }
      
      public function set reportLimit(param1:int) : void
      {
         var_1135 = param1;
      }
      
      private function updateGarbageMonitor() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Array = var_1379.list;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _loc2_ = new GarbageTester("tester");
            var_1379.insert(_loc2_,"tester");
            return _loc2_;
         }
         return null;
      }
      
      public function set reportInterval(param1:int) : void
      {
         var_1133 = param1;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Object = updateGarbageMonitor();
         if(_loc2_ != null)
         {
            ++var_917;
            Logger.log("Garbage collection");
         }
         if(param1 > var_1132)
         {
            ++var_918;
         }
         else
         {
            ++var_548;
            if(var_548 <= 1)
            {
               var_509 = param1;
            }
            else
            {
               _loc3_ = Number(var_548);
               var_509 = var_509 * (_loc3_ - 1) / _loc3_ + Number(param1) / _loc3_;
            }
         }
         if(getTimer() - var_1134 > var_1133 * 1000 && var_1380 < var_1135)
         {
            if(sendReport())
            {
               var_1134 = getTimer();
               ++var_1380;
            }
         }
      }
      
      private function sendReport() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_connection != null)
         {
            _loc1_ = null;
            _loc2_ = getTimer() / 1000;
            _loc3_ = -1;
            _loc4_ = 0;
            Logger.log("*** Performance tracker: average frame rate " + 1000 / var_509);
            _loc1_ = new PerformanceLogMessageComposer(_loc2_,var_1862,var_1861,var_1863,var_1925,var_1174,_loc4_,_loc3_,var_917,var_509,var_918);
            _connection.send(_loc1_);
            var_917 = 0;
            var_509 = 0;
            var_548 = 0;
            var_918 = 0;
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
      }
      
      public function set slowUpdateLimit(param1:int) : void
      {
         var_1132 = param1;
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         var_160 = param1;
         var_1133 = int(var_160.getKey("performancetest.interval","60"));
         var_1132 = int(var_160.getKey("performancetest.slowupdatelimit","1000"));
         var_1135 = int(var_160.getKey("performancetest.reportlimit","10"));
      }
   }
}
