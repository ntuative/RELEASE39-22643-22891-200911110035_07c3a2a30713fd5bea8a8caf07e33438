package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.profiler.ProfilerAgent;
   import flash.events.Event;
   import flash.net.LocalConnection;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   class Profiler extends Component implements IProfiler
   {
      
      public static const PROFILER_START:String = "PROFILER_START";
      
      public static const PROFILER_STOP:String = "PROFILER_STOP";
       
      
      private var var_1569:int;
      
      private var _profilersByReceiver:Dictionary;
      
      private var var_2063:int;
      
      function Profiler(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         _profilersByReceiver = new Dictionary(true);
         super(param1,param2,param3);
      }
      
      public function stop() : void
      {
         var_2063 = getTimer() - var_1569;
         events.dispatchEvent(new Event(PROFILER_STOP,false,false));
      }
      
      public function addStartEventListener(param1:Function) : void
      {
         events.addEventListener(PROFILER_START,param1);
      }
      
      public function update(param1:ICoreUpdateReceiver, param2:uint) : void
      {
         getProfilerAgentForReceiver(param1).update(param2);
      }
      
      public function get numAllocatedBitmapDataBytes() : uint
      {
         return BitmapDataAsset.allocatedByteCount;
      }
      
      public function getProfilerAgentForReceiver(param1:ICoreUpdateReceiver) : ProfilerAgent
      {
         var _loc2_:ProfilerAgent = _profilersByReceiver[param1];
         return _loc2_ != null ? _loc2_ : addProfilerAgentForReceiver(param1);
      }
      
      public function removeStartEventListener(param1:Function) : void
      {
         events.removeEventListener(PROFILER_START,param1);
      }
      
      public function gc() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      public function addProfilerAgentForReceiver(param1:ICoreUpdateReceiver) : ProfilerAgent
      {
         if(false)
         {
            throw new Error("Profiler for receiver already exists!");
         }
         var _loc2_:ProfilerAgent = new ProfilerAgent(param1);
         _profilersByReceiver[param1] = _loc2_;
         return _loc2_;
      }
      
      public function get numBitmapAssetInstances() : uint
      {
         return BitmapDataAsset.instances;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(!disposed)
         {
            for(_loc1_ in _profilersByReceiver)
            {
               IDisposable(_profilersByReceiver[_loc1_]).dispose();
               delete _profilersByReceiver[_loc1_];
            }
            super.dispose();
         }
      }
      
      public function getProfilerAgentsInArray() : Array
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = new Array();
         for(_loc3_ in _profilersByReceiver)
         {
            _loc2_ = _loc3_ as ICoreUpdateReceiver;
            if(IDisposable(_loc3_).disposed)
            {
               IDisposable(_profilersByReceiver[_loc3_]).dispose();
               delete _profilersByReceiver[_loc3_];
            }
            else
            {
               _loc1_.push(_profilersByReceiver[_loc3_]);
            }
         }
         return _loc1_;
      }
      
      public function start() : void
      {
         events.dispatchEvent(new Event(PROFILER_START,false,false));
         var_1569 = getTimer();
      }
      
      public function removeStopEventListener(param1:Function) : void
      {
         events.removeEventListener(PROFILER_STOP,param1);
      }
      
      public function addStopEventListener(param1:Function) : void
      {
         events.addEventListener(PROFILER_STOP,param1);
      }
      
      public function get numAssetLibraryInstances() : uint
      {
         return AssetLibrary.numAssetLibraryInstances;
      }
      
      public function get numProfilerAgents() : uint
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for(_loc2_ in _profilersByReceiver)
         {
            if(!IDisposable(_loc2_).disposed)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
   }
}
