package com.sulake.core.window.utils
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   
   public class XMLPropertyArrayParser extends XMLVariableParser
   {
       
      
      public function XMLPropertyArrayParser()
      {
         super();
      }
      
      public static function parse(param1:XMLList) : Array
      {
         var _loc5_:int = 0;
         var _loc2_:Map = new Map();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         _loc5_ = XMLVariableParser.parseVariableList(param1,_loc2_,_loc3_);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_.push(new PropertyStruct(_loc2_.getKey(_loc6_),_loc2_.getWithIndex(_loc6_),_loc3_[_loc6_],true));
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
