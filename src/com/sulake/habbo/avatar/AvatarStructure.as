package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.AvatarActionManager;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.animation.AddDataContainer;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.animation.AnimationManager;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.avatar.geometry.AvatarModelGeometry;
   import com.sulake.habbo.avatar.geometry.GeometryBodyPart;
   import com.sulake.habbo.avatar.geometry.GeometryItem;
   import com.sulake.habbo.avatar.structure.AnimationData;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.AvatarStructureDownload;
   import com.sulake.habbo.avatar.structure.AvatarStructureDownloadSet;
   import com.sulake.habbo.avatar.structure.FigureData;
   import com.sulake.habbo.avatar.structure.IFigureData;
   import com.sulake.habbo.avatar.structure.PartSetsData;
   import com.sulake.habbo.avatar.structure.animation.ActionPart;
   import com.sulake.habbo.avatar.structure.animation.AnimationAction;
   import com.sulake.habbo.avatar.structure.figure.FigurePart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.parts.PartDefinition;
   import com.sulake.habbo.avatar.structure.parts.PartOffsetData;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class AvatarStructure extends EventDispatcher
   {
      
      public static const AVATAR_STRUCTURE_INIT:String = "AVATAR_STRUCTURE_INIT";
      
      public static const DOWNLOAD_SET_DONE:String = "DOWNLOAD_SET_DONE";
       
      
      private var var_369:PartSetsData;
      
      private var var_1864:PartOffsetData;
      
      private var _animationData:AnimationData;
      
      private var _geometry:AvatarModelGeometry;
      
      private var var_767:String;
      
      private var var_1384:AvatarStructureDownloadSet;
      
      private var var_766:AvatarActionManager;
      
      private var var_150:IAssetLibrary;
      
      private var var_2064:IAssetLibrary;
      
      private var var_1222:Boolean = false;
      
      private var var_438:FigureData;
      
      private var var_622:AnimationManager;
      
      public function AvatarStructure(param1:IAssetLibrary, param2:IAssetLibrary, param3:String)
      {
         super();
         var_150 = param1;
         var_2064 = param2;
         var_438 = new FigureData();
         var_369 = new PartSetsData();
         _animationData = new AnimationData();
         var_1384 = new AvatarStructureDownloadSet();
         var_622 = new AnimationManager();
         var_767 = param3;
         var_1864 = PartOffsetData.getInstance(param1);
      }
      
      public function getPartColor(param1:AvatarFigureContainer, param2:String) : IPartColor
      {
         var _loc3_:int = param1.getPartColorId(param2);
         var _loc4_:ISetType = var_438.getSetType(param2);
         if(_loc4_ == null)
         {
            return null;
         }
         return var_438.getPalette(_loc4_.paletteID).getColor(_loc3_);
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         return _geometry.isMainAvatarSet(param1);
      }
      
      public function getActionDefinitionWithState(param1:String) : ActionDefinition
      {
         return var_766.getActionDefinitionWithState(param1);
      }
      
      public function getAnimation(param1:String) : Animation
      {
         return var_622.getAnimation(param1);
      }
      
      public function init(param1:IHabboConfigurationManager) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         initGeometry();
         initActions();
         var _loc2_:String = param1.getKey("external.figurepartlist.txt");
         var _loc6_:Boolean = false;
         switch(var_767)
         {
            case AvatarType.const_118:
               _loc3_ = var_150.getAssetByName("HabboAvatarPartSets").content as XML;
               if(!var_369.parse(_loc3_))
               {
                  return;
               }
               _loc4_ = var_150.getAssetByName("HabboAvatarAnimation").content as XML;
               if(!_animationData.parse(_loc4_))
               {
                  return;
               }
               _loc5_ = var_150.getAssetByName("HabboAvatarFigure").content as XML;
               if(!var_438.parse(_loc5_))
               {
                  return;
               }
               var_1384.add(new AvatarStructureDownload(var_150,_loc2_,var_438));
               _loc6_ = true;
               break;
            case AvatarType.PET:
               _loc3_ = var_150.getAssetByName("HabboAvatarPetPartSets").content as XML;
               if(!var_369.parse(_loc3_))
               {
                  return;
               }
               _loc4_ = var_150.getAssetByName("HabboAvatarPetAnimation").content as XML;
               if(!_animationData.parse(_loc4_))
               {
                  return;
               }
               _loc5_ = var_150.getAssetByName("HabboAvatarPetFigure").content as XML;
               if(!var_438.parse(_loc5_))
               {
                  return;
               }
               break;
         }
         if(_loc6_)
         {
            var_1384.addEventListener(AvatarStructureDownloadSet.DOWNLOAD_SET_DONE,onStructureReady);
         }
         else
         {
            onStructureReady();
         }
      }
      
      public function getCanvasOffsets(param1:Array, param2:String, param3:int) : Array
      {
         return var_766.getCanvasOffsets(param1,param2,param3);
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         return _geometry.getCanvas(param1,param2);
      }
      
      public function getActionDefinition(param1:String) : ActionDefinition
      {
         return var_766.getActionDefinition(param1);
      }
      
      public function displayGeometry(param1:Stage) : void
      {
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null;
         var _loc2_:BitmapData = new BitmapData(960,540,false,4294967295);
         var _loc3_:Bitmap = new Bitmap(_loc2_);
         param1.addChild(_loc3_);
         var _loc4_:Number = _loc2_.width / 2;
         var _loc5_:Number = _loc2_.height / 2;
         var _loc7_:TextField = new TextField();
         var _loc8_:Matrix = new Matrix();
         for each(_loc9_ in _geometry.getBodyPartIdsInAvatarSet("full"))
         {
            _loc10_ = _geometry.getBodyPart("vertical",_loc9_);
            Logger.log("Drawing bodypart : " + _loc9_);
            if(_loc10_ != null)
            {
               _loc11_ = _loc10_.location.x * 200;
               _loc12_ = _loc10_.location.z * 200;
               _loc13_ = _loc10_.radius * 200;
               _loc14_ = new Shape();
               _loc14_.graphics.lineStyle(1,4294901760,1);
               _loc14_.graphics.drawCircle(_loc4_ + _loc11_,_loc5_ + _loc12_,_loc13_);
               _loc2_.draw(_loc14_);
               _loc7_.text = _loc9_;
               _loc7_.textColor = 4294901760;
               _loc8_.identity();
               _loc8_.tx = _loc4_ + _loc11_ + _loc13_ - _loc7_.textWidth - 5;
               _loc8_.ty = _loc5_ + _loc12_ - 5;
               _loc2_.draw(_loc7_,_loc8_);
            }
            else
            {
               Logger.log("Could not draw bodypart : " + _loc9_);
            }
         }
      }
      
      public function getActiveBodyPartIds(param1:IActiveActionData) : Array
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc2_:* = [];
         var _loc3_:Array = new Array();
         var _loc4_:String = param1.definition.geometryType;
         if(param1.definition.isAnimation)
         {
            _loc6_ = param1.definition.state + "." + param1.actionParameter;
            _loc7_ = var_622.getAnimation(_loc6_);
            if(_loc7_ != null)
            {
               _loc2_ = _loc7_.getAnimatedBodyPartIds(0);
               if(_loc7_.hasAddData())
               {
                  for each(_loc9_ in _loc7_.addData)
                  {
                     _loc5_ = _geometry.getBodyPart(_loc4_,_loc9_.align);
                     if(_loc5_ != null)
                     {
                        _loc10_ = <item id="" x="0" y="0" z="0" radius="0.01" nx="0" ny="0" nz="-1" double="1"/>;
                        _loc10_.@id = _loc9_.id;
                        _loc5_.addPart(_loc10_);
                        _loc11_ = <part/>;
                        _loc11_["set-type"] = _loc9_.id;
                        _loc12_ = var_369.addPartDefinition(_loc11_);
                        _loc12_.appendToFigure = true;
                        if(_loc9_.base == "")
                        {
                           _loc12_.staticId = 1;
                        }
                        if(_loc3_.indexOf(_loc5_.id) == -1)
                        {
                           _loc3_.push(_loc5_.id);
                        }
                     }
                  }
               }
            }
            for each(_loc8_ in _loc2_)
            {
               _loc5_ = _geometry.getBodyPart(_loc4_,_loc8_);
               if(_loc5_ != null)
               {
                  if(_loc3_.indexOf(_loc5_.id) == -1)
                  {
                     _loc3_.push(_loc5_.id);
                  }
               }
            }
         }
         else
         {
            _loc2_ = var_369.getActiveParts(param1.definition);
            for each(_loc13_ in _loc2_)
            {
               _loc5_ = _geometry.getBodyPartOfItem(_loc4_,_loc13_);
               if(_loc5_ != null)
               {
                  if(_loc3_.indexOf(_loc5_.id) == -1)
                  {
                     _loc3_.push(_loc5_.id);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function getParts(param1:String, param2:AvatarFigureContainer, param3:IActiveActionData, param4:String, param5:int) : Array
      {
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = null;
         var _loc24_:* = null;
         var _loc25_:* = null;
         var _loc26_:* = null;
         var _loc27_:* = null;
         var _loc28_:* = null;
         var _loc29_:* = null;
         var _loc30_:* = null;
         var _loc31_:* = null;
         var _loc32_:* = null;
         var _loc33_:Boolean = false;
         var _loc34_:* = null;
         var _loc35_:Boolean = false;
         var _loc36_:* = NaN;
         var _loc37_:int = 0;
         var _loc38_:* = null;
         if(param3 == null)
         {
            Logger.log("[AvatarStructure] getParts action == NULL!! bodyPartId: " + param1);
            return [];
         }
         if(param1 == "item")
         {
            if(param2.getPartTypeIds().indexOf("ri") >= 0)
            {
               Logger.log("let\'s follow how this goes...");
            }
         }
         var _loc6_:ActionDefinition = var_766.getDefaultActionType();
         var _loc7_:Array = var_369.getActiveParts(param3.definition);
         if(param3.definition.isAnimation)
         {
            _loc17_ = param3.definition.state + "." + param3.actionParameter;
            _loc8_ = var_622.getAnimation(_loc17_);
            if(_loc8_ != null)
            {
               _loc10_ = _loc8_.getAnimatedBodyPartIds(0);
            }
            for each(_loc18_ in _loc10_)
            {
               if(_loc18_ == param1)
               {
                  _loc19_ = _geometry.getBodyPart(param4,_loc18_);
                  if(_loc19_ != null)
                  {
                     for each(_loc20_ in _loc19_.getDynamicParts())
                     {
                        _loc7_.push(_loc20_.id);
                     }
                  }
               }
            }
         }
         var _loc9_:Array = _geometry.getParts(param4,param1,param5,_loc7_);
         _loc10_ = new Array();
         var _loc12_:Array = new Array();
         for each(_loc14_ in param2.getPartTypeIds())
         {
            _loc21_ = param2.getPartSetId(_loc14_);
            _loc22_ = param2.getPartColorId(_loc14_);
            _loc23_ = var_438.getSetType(_loc14_);
            if(_loc23_ != null)
            {
               _loc24_ = var_438.getPalette(_loc23_.paletteID).getColor(_loc22_);
               _loc25_ = _loc23_.getPartSet(_loc21_);
               if(_loc25_ != null)
               {
                  _loc12_ = _loc12_.concat(_loc25_.hiddenLayers);
                  for each(_loc26_ in _loc25_.parts)
                  {
                     if(_loc9_.indexOf(_loc26_.type) > -1)
                     {
                        _loc27_ = [0];
                        _loc28_ = _animationData.getAction(param3.definition);
                        if(_loc28_ != null)
                        {
                           _loc32_ = _loc28_.getPart(_loc26_.type);
                           if(_loc32_ != null)
                           {
                              _loc27_ = _loc32_.frames;
                           }
                        }
                        _loc29_ = param3.definition;
                        if(_loc7_.indexOf(_loc26_.type) == -1)
                        {
                           _loc29_ = _loc6_;
                        }
                        _loc13_ = var_369.getPartDefinition(_loc26_.type);
                        _loc30_ = _loc13_ == null ? _loc26_.type : _loc13_.flippedSetType;
                        if(_loc30_ == "")
                        {
                           _loc30_ = _loc26_.type;
                        }
                        _loc31_ = new AvatarImagePartContainer(param1,_loc26_.type,_loc26_.id,_loc24_,_loc27_,_loc29_,_loc26_.isColorable,_loc26_.paletteMap,_loc30_);
                        _loc10_.push(_loc31_);
                     }
                  }
               }
            }
         }
         _loc16_ = new Array();
         for each(_loc11_ in _loc9_)
         {
            _loc33_ = false;
            for each(_loc15_ in _loc10_)
            {
               if(_loc15_.partType == _loc11_)
               {
                  _loc33_ = true;
                  if(_loc12_.indexOf(_loc11_) == -1)
                  {
                     _loc16_.push(_loc15_);
                  }
               }
            }
            if(!_loc33_)
            {
               if(_loc7_.indexOf(_loc11_) > -1)
               {
                  _loc34_ = _geometry.getBodyPartOfItem(param4,_loc11_);
                  if(param1 != _loc34_.id)
                  {
                     Logger.log("BodypartId mismatch:" + param1 + " " + _loc34_.id);
                  }
                  else
                  {
                     _loc13_ = var_369.getPartDefinition(_loc11_);
                     _loc35_ = false;
                     _loc36_ = 1;
                     if(_loc13_.appendToFigure)
                     {
                        Logger.log("PART NOT FOUND, ALTHOUGH IT SHOULD HAVE BEEN! Add now?" + _loc11_);
                        _loc37_ = 1;
                        if(param3.actionParameter != "")
                        {
                           _loc37_ = parseInt(param3.actionParameter);
                        }
                        if(_loc13_.hasStaticId())
                        {
                           _loc37_ = _loc13_.staticId;
                           _loc13_.staticId = -1;
                        }
                        if(_loc8_ != null)
                        {
                           _loc38_ = _loc8_.getAddData(_loc11_);
                           if(_loc38_ != null)
                           {
                              _loc35_ = _loc38_.isBlended;
                              _loc36_ = Number(_loc38_.blend);
                           }
                        }
                        _loc31_ = new AvatarImagePartContainer(param1,_loc11_,_loc37_,null,[0],param3.definition,false,-1,_loc11_,_loc35_,_loc36_);
                        _loc16_.push(_loc31_);
                     }
                  }
               }
            }
         }
         return _loc16_;
      }
      
      public function removeDynamicItems() : void
      {
         _geometry.removeDynamicItems();
      }
      
      public function get figureData() : IFigureData
      {
         return var_438;
      }
      
      private function initGeometry() : void
      {
         var _loc1_:* = null;
         switch(var_767)
         {
            case AvatarType.const_118:
               if(var_150.hasAsset("HabboAvatarGeometry"))
               {
                  _loc1_ = var_150.getAssetByName("HabboAvatarGeometry").content as XML;
                  _geometry = new AvatarModelGeometry(_loc1_);
               }
               else
               {
                  Logger.log("[AvatarStructure] Could not init human Geometry");
               }
               break;
            case AvatarType.PET:
               if(var_150.hasAsset("HabboAvatarPetGeometry"))
               {
                  _loc1_ = var_150.getAssetByName("HabboAvatarPetGeometry").content as XML;
                  _geometry = new AvatarModelGeometry(_loc1_);
               }
               else
               {
                  Logger.log("[AvatarStructure] Could not init pet Geometry");
               }
         }
      }
      
      private function registerAnimations() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 1;
         while(var_150.hasAsset("dance" + _loc1_))
         {
            _loc2_ = var_150.getAssetByName("dance" + _loc1_).content as XML;
            var_622.registerAnimation(this,_loc2_);
            _loc1_++;
         }
         _loc1_ = 1;
         while(var_150.hasAsset("fx" + _loc1_))
         {
            _loc2_ = var_150.getAssetByName("fx" + _loc1_).content as XML;
            var_622.registerAnimation(this,_loc2_);
            _loc1_++;
         }
      }
      
      public function getBodyPartData(param1:String, param2:int, param3:String) : AnimationLayerData
      {
         return var_622.getLayerData(param1,param2,param3);
      }
      
      public function getBodyParts(param1:String, param2:IActionDefinition, param3:int) : Array
      {
         var _loc4_:Number = AvatarDirectionAngle.const_1267[param3];
         return _geometry.getBodyPartsAtAngle(param1,_loc4_,param2);
      }
      
      public function getPartActionOffset(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int) : Point
      {
         return var_1864.getOffset(param1,param2,param3,param4,param5,param6);
      }
      
      private function initActions() : void
      {
         var_766 = new AvatarActionManager(var_150,var_767);
      }
      
      public function getBodyPartsUnordered(param1:String) : Array
      {
         return _geometry.getBodyPartIdsInAvatarSet(param1);
      }
      
      private function onStructureReady(param1:Event = null) : void
      {
         Logger.log("[AvatarStructure] Structure " + var_767 + " ready to go!");
         if(var_767 == AvatarType.const_118)
         {
            var_369.getPartDefinition("ri").appendToFigure = true;
            var_369.getPartDefinition("li").appendToFigure = true;
         }
         registerAnimations();
         dispatchEvent(new Event(AVATAR_STRUCTURE_INIT));
      }
      
      public function sortActions(param1:Array) : Array
      {
         return var_766.sortActions(param1);
      }
   }
}
