package com.sulake.habbo.avatar.actions
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import flash.utils.Dictionary;
   
   public class AvatarActionManager
   {
       
      
      private var var_150:IAssetLibrary;
      
      private var var_767:String;
      
      private var var_231:Dictionary;
      
      public function AvatarActionManager(param1:IAssetLibrary, param2:String)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         super();
         var_150 = param1;
         var_231 = new Dictionary();
         var_767 = param2;
         switch(param2)
         {
            case AvatarType.const_118:
               if(!var_150.hasAsset("HabboAvatarActions"))
               {
                  Logger.log("[AvatarStructure] Could not init human Action Data.");
               }
               else
               {
                  _loc3_ = var_150.getAssetByName("HabboAvatarActions").content as XML;
               }
               break;
            case AvatarType.PET:
               if(!var_150.hasAsset("HabboAvatarPetActions"))
               {
                  Logger.log("[AvatarStructure] Could not init pet Action Data.");
               }
               else
               {
                  _loc3_ = var_150.getAssetByName("HabboAvatarPetActions").content as XML;
               }
         }
         if(_loc3_ == null)
         {
            return;
         }
         for each(_loc4_ in _loc3_.action)
         {
            _loc5_ = String(_loc4_.@state);
            if(_loc5_ != "")
            {
               _loc6_ = new ActionDefinition(_loc4_);
               var_231[_loc5_] = _loc6_;
            }
         }
         parseActionOffsets();
      }
      
      private function filterActions(param1:Array) : Array
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_] as ActiveActionData;
            _loc5_ = var_231[_loc4_.actionType] as ActionDefinition;
            if(_loc5_ != null)
            {
               _loc3_ = _loc3_.concat(_loc5_.getPrevents(_loc4_.actionParameter));
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_] as ActiveActionData;
            _loc7_ = _loc4_.actionType;
            if(_loc4_.actionType == "fx")
            {
               _loc7_ += "." + _loc4_.actionParameter;
            }
            if(_loc3_.indexOf(_loc7_) == -1)
            {
               _loc2_.push(_loc4_);
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public function sortActions(param1:Array) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         param1 = filterActions(param1);
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc4_ = var_231[_loc3_.actionType];
            if(_loc4_ != null)
            {
               _loc3_.definition = _loc4_;
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(orderByPrecedence);
         return _loc2_;
      }
      
      public function getActionDefinitionWithState(param1:String) : ActionDefinition
      {
         return var_231[param1];
      }
      
      private function orderByPrecedence(param1:IActiveActionData, param2:IActiveActionData) : Number
      {
         var _loc3_:Number = param1.definition.precedence;
         var _loc4_:Number = param2.definition.precedence;
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function getCanvasOffsets(param1:Array, param2:String, param3:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc5_ = param1[_loc7_] as ActiveActionData;
            _loc6_ = var_231[_loc5_.actionType] as ActionDefinition;
            if(_loc6_ != null && _loc6_.getOffsets(param2,param3) != null)
            {
               _loc4_ = _loc6_.getOffsets(param2,param3);
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      private function parseActionOffsets() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:* = null;
         for each(_loc2_ in var_231)
         {
            _loc3_ = _loc2_.state;
            if(var_150.hasAsset("action_offset_" + _loc3_))
            {
               _loc4_ = var_150.getAssetByName("action_offset_" + _loc3_).content as XML;
               if(_loc4_.@avatartype == var_767)
               {
                  for each(_loc10_ in _loc4_.offset)
                  {
                     _loc5_ = String(_loc10_.@size);
                     _loc6_ = parseInt(_loc10_.@direction);
                     _loc7_ = parseInt(_loc10_.@x);
                     _loc8_ = parseInt(_loc10_.@y);
                     _loc9_ = Number(_loc10_.@z);
                     _loc2_.setOffsets(_loc5_,_loc6_,new Array(_loc7_,_loc8_,_loc9_));
                  }
               }
            }
         }
      }
      
      public function getDefaultActionType() : ActionDefinition
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_231)
         {
            if(_loc1_.isDefault)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getActionDefinition(param1:String) : ActionDefinition
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_231)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
