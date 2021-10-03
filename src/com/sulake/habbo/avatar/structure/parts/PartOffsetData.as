package com.sulake.habbo.avatar.structure.parts
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import flash.geom.Point;
   
   public final class PartOffsetData
   {
      
      private static var _offsets:Map = new Map();
      
      private static var _instance:PartOffsetData;
      
      private static var _parsed:Boolean = false;
       
      
      public function PartOffsetData()
      {
         super();
         if(PartOffsetData._instance != null)
         {
            throw new Error("PartOffsetData is a singleton class. Use getInstance() instead of constructor!");
         }
      }
      
      private static function parseXml(param1:XML) : Map
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Map = new Map();
         for each(_loc3_ in param1.parttype)
         {
            _loc4_ = _loc3_.@type;
            _loc5_ = _loc2_.getValue(_loc4_);
            if(_loc5_ == null)
            {
               _loc5_ = new Map();
               _loc2_.add(_loc4_,_loc5_);
            }
            for each(_loc6_ in _loc3_.mainaction)
            {
               _loc7_ = _loc6_.@type;
               _loc8_ = _loc5_.getValue(_loc7_);
               if(_loc8_ == null)
               {
                  _loc8_ = new Map();
                  _loc5_.add(_loc7_,_loc8_);
               }
               for each(_loc9_ in _loc6_.frame)
               {
                  _loc10_ = _loc9_.@number;
                  _loc11_ = _loc8_.getValue(_loc10_);
                  if(_loc11_ == null)
                  {
                     _loc11_ = new Map();
                     _loc8_.add(_loc10_,_loc11_);
                  }
                  for each(_loc12_ in _loc9_.offset)
                  {
                     if(String(_loc12_.@aliasaction) != null && String(_loc12_.@aliasaction) != "")
                     {
                        _loc13_ = new Object();
                        _loc13_.aliasAction = new String(_loc12_.@aliasaction);
                        _loc13_.aliasFrame = new int(_loc12_.@aliasframe);
                        _loc11_.add("alias",_loc13_);
                     }
                     else
                     {
                        _loc14_ = _loc12_.@direction;
                        _loc11_.add(_loc14_,new Point(_loc12_.@x,_loc12_.@y));
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public static function getInstance(param1:IAssetLibrary) : PartOffsetData
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(PartOffsetData._instance == null)
         {
            PartOffsetData._instance = new PartOffsetData();
            _loc2_ = ["PartOffsetsLarge1","PartOffsetsSmall1","PartOffsetsLarge2","PartOffsetsSmall2"];
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = param1.getAssetByName(_loc3_).content as XML;
               PartOffsetData._offsets.add(_loc3_,parseXml(_loc4_));
            }
            PartOffsetData._parsed = true;
         }
         return PartOffsetData._instance;
      }
      
      public function getOffset(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int) : Point
      {
         var _loc12_:* = null;
         var _loc13_:* = null;
         if(PartOffsetData._offsets == null)
         {
            return null;
         }
         if(param2 == "h")
         {
            param2 = "Large";
         }
         else if(param2 == "sh")
         {
            param2 = "Small";
         }
         switch(param1)
         {
            case AvatarType.const_229:
            case AvatarType.const_299:
               param1 = "1";
               break;
            case AvatarType.const_287:
               param1 = "2";
               break;
            default:
               param1 = "1";
         }
         var _loc7_:String = "PartOffsets" + param2 + "" + param1;
         var _loc8_:Map = PartOffsetData._offsets.getValue(_loc7_);
         if(_loc8_ == null)
         {
            return null;
         }
         var _loc9_:Map = _loc8_.getValue(param3);
         if(_loc9_ == null)
         {
            return null;
         }
         var _loc10_:Map = _loc9_.getValue(param4);
         if(_loc10_ == null)
         {
            return null;
         }
         var _loc11_:Map = _loc10_.getValue(String(param5));
         if(_loc11_ == null)
         {
            return null;
         }
         if(_loc11_.getValue("alias") != null)
         {
            _loc12_ = _loc11_.getValue("alias");
            return getOffset(param1,param2,param3,_loc12_.aliasAction as String,_loc12_.aliasFrame,param6);
         }
         _loc13_ = _loc11_.getValue(String(param6));
         if(_loc13_ == null)
         {
            return null;
         }
         return _loc13_.clone();
      }
   }
}
