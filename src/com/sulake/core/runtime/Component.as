package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.runtime.exceptions.ComponentDisposedException;
   import com.sulake.core.runtime.exceptions.ComponentLockedException;
   import com.sulake.core.runtime.exceptions.InvalidComponentException;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class Component implements IUnknown
   {
      
      public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
      
      public static const const_1351:uint = 1;
      
      public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
      
      public static const const_1229:uint = 4;
      
      public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
      
      public static const COMPONENT_FLAG_NULL:uint = 0;
      
      public static const COMPONENT_FLAG_CONTEXT:uint = 2;
      
      public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
       
      
      protected var var_979:uint;
      
      protected var _isDisposed:Boolean = false;
      
      protected var _lastError:String = "";
      
      protected var var_175:InterfaceStructList;
      
      protected var var_2036:String = "";
      
      protected var _assets:IAssetLibrary;
      
      protected var var_389:uint = 0;
      
      protected var _context:IContext = null;
      
      protected var var_1667:Boolean = false;
      
      protected var name_1:EventDispatcher;
      
      public function Component(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super();
         var_979 = param2;
         var_175 = new InterfaceStructList();
         name_1 = new EventDispatcher();
         _context = param1;
         _assets = param3 != null ? param3 : new AssetLibrary("_internal_asset_library");
         if(_context == null)
         {
            throw new InvalidComponentException("IContext not provided to Component\'s constructor!");
         }
      }
      
      public function get assets() : IAssetLibrary
      {
         return _assets;
      }
      
      public function release(param1:IID) : uint
      {
         if(_isDisposed)
         {
            return 0;
         }
         var _loc2_:InterfaceStruct = var_175.getStructByInterface(param1);
         if(_loc2_ == null)
         {
            _lastError = "Attempting to release unknown interface:" + param1 + "!";
            throw new Error(_lastError);
         }
         var _loc3_:uint = _loc2_.release();
         if(var_979 & const_1229)
         {
            if(_loc3_ == 0)
            {
               if(var_175.getTotalReferenceCount() == 0)
               {
                  _context.detachComponent(this);
                  this.dispose();
               }
            }
         }
         return _loc3_;
      }
      
      public function get locked() : Boolean
      {
         return var_1667;
      }
      
      public function removeUpdateReceiver(param1:ICoreUpdateReceiver) : void
      {
         _context.removeUpdateReceiver(param1);
      }
      
      public function toXMLString(param1:uint = 0) : String
      {
         var _loc6_:* = null;
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += "\t";
            _loc3_++;
         }
         var _loc4_:String = getQualifiedClassName(this);
         var _loc5_:String = "";
         _loc5_ += _loc2_ + "<component class=\"" + _loc4_ + "\">\n";
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = var_175.getStructByIndex(_loc8_);
            _loc5_ += _loc2_ + "\t<interface iid=\"" + _loc6_.iis + "\" refs=\"" + _loc6_.references + "/>\n";
            _loc8_++;
         }
         return _loc5_ + (_loc2_ + "</component>\n");
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function registerUpdateReceiver(param1:ICoreUpdateReceiver, param2:uint) : void
      {
         _context.registerUpdateReceiver(param1,param2);
      }
      
      public function dispose() : void
      {
         if(!_isDisposed)
         {
            Logger.log("Disposing component " + getQualifiedClassName(this));
            name_1.dispatchEvent(new Event(Component.COMPONENT_EVENT_DISPOSING));
            name_1 = null;
            var_175.dispose();
            var_175 = null;
            _assets.dispose();
            _assets = null;
            _context = null;
            var_389 = 0;
            _isDisposed = true;
         }
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         var _loc3_:InterfaceStruct = var_175.getStructByInterface(param1);
         if(_loc3_ == null)
         {
            return _context.queueInterface(param1,param2);
         }
         if(_isDisposed)
         {
            throw new ComponentDisposedException("Failed to queue interface trough disposed Component \"" + getQualifiedClassName(this) + "\"!");
         }
         if(var_1667)
         {
            throw new ComponentLockedException("Failed to queue interface trough locked Component \"" + getQualifiedClassName(this) + "\"!");
         }
         _loc3_.reserve();
         var _loc4_:IUnknown = _loc3_.unknown as IUnknown;
         if(param2 != null)
         {
            param2(param1,_loc4_);
         }
         return _loc4_;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function get iids() : InterfaceStructList
      {
         return var_175;
      }
      
      public function get context() : IContext
      {
         return _context;
      }
      
      public function toString() : String
      {
         return "[component " + getQualifiedClassName(this) + " refs: " + var_389 + "]";
      }
   }
}
