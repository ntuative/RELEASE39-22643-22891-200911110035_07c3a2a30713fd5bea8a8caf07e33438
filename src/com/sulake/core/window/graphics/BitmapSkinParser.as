package com.sulake.core.window.graphics
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.graphics.renderer.BitmapSkinTemplate;
   import com.sulake.core.window.graphics.renderer.BitmapSkinTemplateEntity;
   import com.sulake.core.window.graphics.renderer.ISkinLayout;
   import com.sulake.core.window.graphics.renderer.ISkinLayoutEntity;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.graphics.renderer.SkinLayout;
   import com.sulake.core.window.graphics.renderer.SkinLayoutEntity;
   import com.sulake.core.window.utils.ChildEntityArray;
   import com.sulake.core.window.utils.IChildEntityArray;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinParser
   {
      
      public static const const_83:String = "active";
      
      public static const const_75:String = "default";
      
      public static const const_59:String = "locked";
      
      public static const const_44:String = "selected";
      
      public static const const_73:String = "hovering";
      
      public static const const_84:String = "pressed";
      
      public static const const_62:String = "disabled";
      
      public static const const_69:String = "focused";
       
      
      public function BitmapSkinParser()
      {
         super();
      }
      
      protected static function parseLayoutEntity(param1:XML, param2:Map) : SkinLayoutEntity
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         _loc11_ = param1.attribute("id");
         _loc3_ = uint(_loc11_ == null ? 0 : uint(uint(_loc11_)));
         _loc11_ = param1.attribute("name");
         _loc4_ = _loc11_ == null ? "" : _loc11_;
         _loc13_ = param1.child("color");
         if(_loc13_.length() > 0)
         {
            _loc12_ = _loc13_[0];
            _loc11_ = String(_loc12_);
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param2[_loc11_.slice(1,_loc11_.length)];
               }
            }
         }
         _loc6_ = uint(_loc11_ == null ? 0 : uint(uint(_loc11_)));
         _loc13_ = param1.child("blend");
         if(_loc13_.length() > 0)
         {
            _loc12_ = _loc13_[0];
            _loc11_ = String(_loc12_);
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param2[_loc11_.slice(1,_loc11_.length)];
               }
            }
         }
         _loc7_ = uint(_loc11_ == null ? 4294967295 : uint(uint(_loc11_)));
         _loc13_ = param1.child("scale");
         if(_loc13_.length() > 0)
         {
            _loc12_ = _loc13_[0];
            _loc11_ = _loc12_.attribute("horizontal");
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param2[_loc11_.slice(1,_loc11_.length)];
               }
            }
            switch(_loc11_)
            {
               case "fixed":
                  _loc8_ = 0;
                  break;
               case "move":
                  _loc8_ = 0;
                  break;
               case "strech":
                  _loc8_ = 0;
                  break;
               case "tiled":
                  _loc8_ = 0;
                  break;
               case "center":
                  _loc8_ = 0;
            }
            _loc11_ = _loc12_.attribute("vertical");
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param2[_loc11_.slice(1,_loc11_.length)];
               }
            }
            switch(_loc11_)
            {
               case "fixed":
                  _loc9_ = 0;
                  break;
               case "move":
                  _loc9_ = 0;
                  break;
               case "strech":
                  _loc9_ = 0;
                  break;
               case "tiled":
                  _loc9_ = 0;
                  break;
               case "center":
                  _loc9_ = 0;
            }
         }
         _loc13_ = param1.child("region");
         if(_loc13_.length() > 0)
         {
            _loc12_ = _loc13_[0];
            _loc13_ = _loc12_.child("Rectangle");
            _loc12_ = _loc13_[0];
            _loc5_ = new Rectangle();
            _loc11_ = _loc12_.attribute("x");
            _loc5_.x = Number(_loc11_.charAt(0) == "$" ? param2[_loc11_.slice(1,_loc11_.length)] : _loc11_);
            _loc11_ = _loc12_.attribute("y");
            _loc5_.y = Number(_loc11_.charAt(0) == "$" ? param2[_loc11_.slice(1,_loc11_.length)] : _loc11_);
            _loc11_ = _loc12_.attribute("width");
            _loc5_.width = Number(_loc11_.charAt(0) == "$" ? param2[_loc11_.slice(1,_loc11_.length)] : _loc11_);
            _loc11_ = _loc12_.attribute("height");
            _loc5_.height = Number(_loc11_.charAt(0) == "$" ? param2[_loc11_.slice(1,_loc11_.length)] : _loc11_);
         }
         return new SkinLayoutEntity(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
      }
      
      protected static function parseLayoutList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc8_:* = null;
         var _loc5_:XMLList = param2.child("layout");
         var _loc6_:uint = _loc5_.length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc5_[_loc7_];
            parseLayout(param1,_loc8_,param3,param4);
            _loc7_++;
         }
      }
      
      protected static function parseTemplateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map, param5:IAssetLibrary) : void
      {
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc6_:XMLList = param2.child("template");
         var _loc7_:uint = _loc6_.length();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = _loc6_[_loc8_];
            _loc10_ = _loc9_.attribute("name");
            if(_loc10_ != null)
            {
               if(_loc10_.charAt(0) == "$")
               {
                  _loc10_ = param4[_loc10_.slice(1,_loc10_.length)];
               }
            }
            _loc11_ = _loc9_.attribute("asset");
            if(_loc11_ != null)
            {
               if(_loc11_.charAt(0) == "$")
               {
                  _loc11_ = param4[_loc11_.slice(1,_loc11_.length)];
               }
            }
            _loc12_ = new BitmapSkinTemplate(_loc10_,param5.getAssetByName(_loc11_));
            _loc13_ = _loc9_.child("entities");
            if(_loc13_.length() > 0)
            {
               _loc14_ = _loc13_[0];
               _loc15_ = _loc14_.child("entity");
               if(_loc15_.length())
               {
                  _loc16_ = _loc15_[0];
                  parseTemplateEntityList(param1,_loc12_,_loc15_,param4);
               }
            }
            param3[_loc10_] = _loc12_;
            param1.addTemplate(_loc12_);
            _loc8_++;
         }
      }
      
      public static function parseSkinDescription(param1:XML, param2:XMLList, param3:ISkinRenderer, param4:String, param5:IAssetLibrary) : void
      {
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = 0;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:* = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = null;
         var _loc6_:XML = param1;
         var _loc7_:Map = new Map();
         var _loc8_:XMLList = _loc6_.child("variables");
         if(_loc8_.length() > 0)
         {
            _loc13_ = _loc8_[0];
            _loc14_ = _loc13_.child("variable");
            if(_loc14_.length())
            {
               XMLVariableParser.parseVariableList(_loc14_,_loc7_);
            }
         }
         var _loc9_:Dictionary = new Dictionary();
         var _loc10_:XMLList = _loc6_.child("templates");
         if(_loc10_[0])
         {
            parseTemplateList(param3,_loc10_[0],_loc9_,_loc7_,param5);
         }
         var _loc11_:Dictionary = new Dictionary();
         var _loc12_:XMLList = _loc6_.child("layouts");
         if(_loc12_[0])
         {
            if(param4 == null)
            {
               parseLayoutList(param3,_loc12_[0],_loc11_,_loc7_);
            }
            else
            {
               _loc15_ = _loc12_[0].child("layout");
               _loc16_ = uint(_loc15_.length());
               _loc17_ = 0;
               while(_loc17_ < _loc16_)
               {
                  _loc18_ = _loc15_[_loc17_];
                  if(_loc18_.attribute("name") == param4)
                  {
                     parseLayout(param3,_loc18_,_loc11_,_loc7_);
                     break;
                  }
                  _loc17_++;
               }
            }
         }
         if(param2.length() == 0)
         {
            param2 = _loc6_.child("states");
         }
         if(param2.length() > 0)
         {
            if(param4 == null)
            {
               parseRenderStateList(param3,param2[0],_loc11_,_loc7_);
            }
            else
            {
               _loc19_ = param2[0].child("state");
               _loc20_ = uint(_loc19_.length());
               _loc21_ = 0;
               _loc22_ = 0;
               while(_loc22_ < _loc20_)
               {
                  _loc23_ = _loc19_[_loc22_];
                  if(_loc23_.attribute("layout") == param4)
                  {
                     parseState(param3,_loc23_,_loc11_,_loc7_);
                     _loc21_++;
                  }
                  _loc22_++;
               }
               if(_loc21_ == 0)
               {
                  Logger.log("Error: No states found for layout \"" + param4 + "\"!");
               }
            }
         }
      }
      
      protected static function parseTemplateEntityList(param1:ISkinRenderer, param2:BitmapSkinTemplate, param3:XMLList, param4:Map) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = 0;
         var _loc14_:* = null;
         var _loc16_:int = 0;
         var _loc15_:int = param3.length();
         _loc16_ = 0;
         while(_loc16_ < _loc15_)
         {
            _loc5_ = param3[_loc16_];
            _loc10_ = _loc5_.attribute("name");
            _loc11_ = _loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_;
            _loc10_ = _loc5_.attribute("type");
            _loc12_ = _loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_;
            _loc10_ = _loc5_.attribute("id");
            _loc13_ = uint(uint(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_));
            _loc6_ = _loc5_.child("region");
            if(_loc6_.length() > 0)
            {
               _loc7_ = _loc6_[0];
               _loc6_ = _loc7_.child("Rectangle");
               _loc7_ = _loc6_[0];
               _loc14_ = new Rectangle();
               _loc10_ = _loc7_.attribute("x");
               _loc14_.x = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("y");
               _loc14_.y = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("width");
               _loc14_.width = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
               _loc10_ = _loc7_.attribute("height");
               _loc14_.height = Number(_loc10_.charAt(0) == "$" ? param4[_loc10_.slice(1,_loc10_.length)] : _loc10_);
            }
            _loc8_ = _loc5_.child("variables");
            if(_loc8_.length() > 0)
            {
               _loc9_ = _loc8_[0];
               _loc8_ = _loc9_.child("variable");
               param4 = new Map();
               XMLVariableParser.parseVariableList(_loc8_,param4);
            }
            param2.addChild(new BitmapSkinTemplateEntity(_loc11_,_loc12_,_loc13_,_loc14_,param4));
            _loc16_++;
         }
      }
      
      protected static function parseState(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc5_:String = param2.attribute("name");
         if(_loc5_.charAt(0) == "$")
         {
            _loc5_ = param4[_loc5_.slice(1,_loc5_.length)];
         }
         var _loc6_:String = param2.attribute("layout");
         if(_loc6_.charAt(0) == "$")
         {
            _loc6_ = param4[_loc6_.slice(1,_loc6_.length)];
         }
         var _loc7_:String = param2.attribute("template");
         if(_loc7_.charAt(0) == "$")
         {
            _loc7_ = param4[_loc7_.slice(1,_loc7_.length)];
         }
         var _loc8_:ISkinLayout = param3[_loc6_];
         if(_loc8_ == null)
         {
            throw new Error("State " + _loc5_ + " has invalid layout reference " + _loc6_ + "!");
         }
         var _loc9_:XMLList = param2.child("variables");
         if(_loc9_.length() > 0)
         {
            _loc11_ = _loc9_[0];
            _loc12_ = _loc11_.child("variable");
            if(_loc12_.length())
            {
               _loc13_ = new Map();
               XMLVariableParser.parseVariableList(_loc12_,_loc13_);
               for(_loc14_ in _loc13_)
               {
                  _loc15_ = _loc13_[_loc14_];
                  if(_loc15_ is String)
                  {
                     if(String(_loc15_).charAt(0) == "$")
                     {
                        _loc15_ = param4[_loc15_.slice(1,_loc15_.length)];
                        _loc13_[_loc14_] = _loc15_;
                     }
                  }
               }
            }
         }
         var _loc10_:int = 0;
         switch(_loc5_)
         {
            case BitmapSkinParser.const_83:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_75:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_69:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_62:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_73:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_84:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_44:
               _loc10_ = 0;
               break;
            case BitmapSkinParser.const_59:
               _loc10_ = 0;
               break;
            default:
               throw new Error("Unknown window state: \"" + _loc5_ + "\"!");
         }
         param1.registerLayoutForRenderState(_loc10_,_loc6_);
         param1.registerTemplateForRenderState(_loc10_,_loc7_);
      }
      
      protected static function parseRenderStateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc5_:XMLList = param2.child("state");
         var _loc6_:uint = _loc5_.length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            parseState(param1,_loc5_[_loc7_],param3,param4);
            _loc7_++;
         }
      }
      
      protected static function parseLayoutPlaceholderList(param1:ISkinRenderer, param2:IChildEntityArray, param3:XMLList, param4:Map) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:uint = param3.length();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc5_ = parseLayoutEntity(param3[_loc6_],param4);
            if(_loc5_ != null)
            {
               param2.addChild(_loc5_);
            }
            _loc6_++;
         }
      }
      
      protected static function parseLayout(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc5_:String = param2.attribute("name");
         var _loc6_:* = param2.attribute("transparent") == "AnimationAction";
         var _loc7_:IChildEntityArray = new ChildEntityArray();
         var _loc8_:SkinLayout = new SkinLayout(_loc5_,_loc6_,_loc7_);
         var _loc9_:XMLList = param2.child("entities");
         if(_loc9_.length() > 0)
         {
            _loc11_ = _loc9_[0];
            _loc12_ = _loc11_.child("entity");
            if(_loc12_.length())
            {
               parseLayoutEntityList(param1,_loc8_,_loc12_,param4);
            }
         }
         var _loc10_:XMLList = param2.child("placeholders");
         if(_loc10_.length() > 0)
         {
            _loc13_ = _loc10_[0];
            _loc14_ = _loc13_.child("placeholder");
            if(_loc14_.length())
            {
               parseLayoutPlaceholderList(param1,_loc7_,_loc14_,param4);
            }
         }
         param3[_loc5_] = _loc8_;
         param1.addLayout(_loc8_);
      }
      
      protected static function parseLayoutEntityList(param1:ISkinRenderer, param2:SkinLayout, param3:XMLList, param4:Map) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:uint = param3.length();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc5_ = parseLayoutEntity(param3[_loc6_],param4);
            if(_loc5_ != null)
            {
               param2.addChild(_loc5_);
            }
            _loc6_++;
         }
      }
   }
}
