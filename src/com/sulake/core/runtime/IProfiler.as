package com.sulake.core.runtime
{
   import com.sulake.core.utils.profiler.ProfilerAgent;
   
   public interface IProfiler
   {
       
      
      function removeStartEventListener(param1:Function) : void;
      
      function get numAllocatedBitmapDataBytes() : uint;
      
      function getProfilerAgentForReceiver(param1:ICoreUpdateReceiver) : ProfilerAgent;
      
      function get numBitmapAssetInstances() : uint;
      
      function get numAssetLibraryInstances() : uint;
      
      function getProfilerAgentsInArray() : Array;
      
      function removeStopEventListener(param1:Function) : void;
      
      function addStopEventListener(param1:Function) : void;
      
      function gc() : void;
      
      function addStartEventListener(param1:Function) : void;
   }
}
