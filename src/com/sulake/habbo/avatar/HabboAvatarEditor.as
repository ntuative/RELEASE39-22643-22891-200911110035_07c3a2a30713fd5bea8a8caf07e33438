package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.common.AvatarEditorColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridItem;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
   import com.sulake.habbo.avatar.enum.AvatarEditorCategory;
   import com.sulake.habbo.avatar.enum.AvatarRenderEvent;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.avatar.events.AvatarEditorClosedEvent;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import com.sulake.habbo.avatar.generic.GenericModel;
   import com.sulake.habbo.avatar.head.HeadModel;
   import com.sulake.habbo.avatar.legs.LegsModel;
   import com.sulake.habbo.avatar.structure.IFigureData;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPalette;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.torso.TorsoModel;
   import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class HabboAvatarEditor extends Component implements IHabboAvatarEditor
   {
       
      
      private var _view:AvatarEditorView;
      
      private var var_1029:AvatarEditorHandler;
      
      private var var_852:Boolean = false;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1016:IAvatarRenderManager;
      
      private var var_357:IWindowContainer;
      
      private var var_306:Map;
      
      private var var_851:Boolean = false;
      
      private var var_577:Dictionary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_84:IHabboCatalog;
      
      private var _gender:String;
      
      private var var_32:IHabboInventory;
      
      private var var_160:IHabboConfigurationManager;
      
      private var var_850:IFigureData;
      
      private var _localization:IHabboLocalizationManager;
      
      public function HabboAvatarEditor(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         _gender = FigureData.const_71;
         super(param1,param2,param3);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderManagerReady);
         queueInterface(new IIDHabboInventory(),onInventoryReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         if(param1 is CoreComponent)
         {
            (param1 as CoreComponent).events.addEventListener(Component.COMPONENT_EVENT_RUNNING,onComponentsRunning);
         }
      }
      
      public function getFigureSetType(param1:String) : ISetType
      {
         if(var_850 == null)
         {
            return null;
         }
         return var_850.getSetType(param1);
      }
      
      public function close() : void
      {
         if(var_357 != null)
         {
            var_357.visible = false;
         }
         else
         {
            this.events.dispatchEvent(new AvatarEditorClosedEvent());
         }
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_84 = param2 as IHabboCatalog;
      }
      
      private function onConfigurationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_160 = param2 as IHabboConfigurationManager;
      }
      
      public function changeSubCategory(param1:String) : void
      {
      }
      
      private function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!var_851)
         {
            var_577 = new Dictionary();
            var_577["null"] = new FigureData(this);
            var_577["null"] = new FigureData(this);
            _loc1_ = var_577["null"];
            _loc2_ = var_577["null"];
            _loc1_.loadAvatarData("hr-681-35.hd-209-7.ch-878-87.lg-281-70.sh-906-77.ea-1401-77.ha-1010-70.he-1601-62.fa-1204-62.ca-1809-62.wa-2007-62",FigureData.const_71);
            _loc2_.loadAvatarData("hr-681-41.hd-620-9.ch-879-90.lg-700-85.sh-735-68",FigureData.const_77);
            var_306 = new Map();
            var_306.add(AvatarEditorCategory.const_818,new GenericModel(this));
            var_306.add(AvatarEditorCategory.const_50,new HeadModel(this));
            var_306.add(AvatarEditorCategory.const_320,new TorsoModel(this));
            var_306.add(AvatarEditorCategory.const_1131,new LegsModel(this));
            var_306.add(AvatarEditorCategory.const_581,new WardrobeModel(this));
            var_851 = true;
         }
      }
      
      public function set gender(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = param1 != _gender;
         _gender = param1;
         for each(_loc3_ in var_306)
         {
            _loc3_.reset();
         }
         if(_view != null)
         {
            _view.updateAvatar();
         }
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      private function requestSavedOutfits() : void
      {
         if(!var_851)
         {
            init();
         }
         var _loc1_:WardrobeModel = var_306.getValue(AvatarEditorCategory.const_581);
         if(_loc1_ != null)
         {
         }
      }
      
      private function method_9(param1:AvatarEditorGridItem, param2:AvatarEditorGridItem) : Number
      {
         var _loc3_:Number = param1.partSet == null ? -1 : Number(Number(param1.partSet.isClub));
         var _loc4_:Number = param2.partSet == null ? -1 : Number(Number(param2.partSet.isClub));
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      public function get isHabboClubMember() : Boolean
      {
         return var_852;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return var_84;
      }
      
      private function onComponentsRunning(param1:Event = null) : void
      {
      }
      
      private function onCommunicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _communication = param2 as IHabboCommunicationManager;
         var_1029 = new AvatarEditorHandler(this,_communication);
      }
      
      override public function dispose() : void
      {
         if(_windowManager != null)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(var_32 != null)
         {
            var_32.release(new IIDHabboInventory());
            var_32 = null;
         }
         super.dispose();
      }
      
      private function onHabboClubChanged(param1:HabboInventoryHabboClubEvent = null) : void
      {
         requestSavedOutfits();
      }
      
      public function getDefaultColour(param1:String) : int
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc2_:ISetType = getFigureSetType(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getPalette(_loc2_.paletteID);
            for each(_loc4_ in _loc3_.colors)
            {
               _loc5_ = true;
               if(_loc4_.club)
               {
                  _loc5_ = var_852;
               }
               if(_loc4_.isSelectable && _loc5_)
               {
                  return _loc4_.id;
               }
            }
         }
         return -1;
      }
      
      public function get figureData() : FigureData
      {
         return var_577[_gender];
      }
      
      public function get wardrobe() : WardrobeModel
      {
         if(!var_851)
         {
            init();
         }
         return var_306.getValue(AvatarEditorCategory.const_581);
      }
      
      public function getPalette(param1:int) : IPalette
      {
         if(var_850 == null)
         {
            return null;
         }
         return var_850.getPalette(param1);
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function toggleAvatarEditorPage(param1:String) : void
      {
         _view.toggleCategoryView(param1,false);
      }
      
      public function get handler() : AvatarEditorHandler
      {
         return var_1029;
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _windowManager = param2 as IHabboWindowManager;
      }
      
      public function generateDataContent(param1:IAvatarEditorCategoryModel, param2:String) : CategoryData
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = false;
         var _loc15_:Boolean = false;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc3_:* = [];
         var _loc4_:* = [];
         var _loc8_:Boolean = false;
         _loc7_ = getFigureSetType(param2);
         switch(param2)
         {
            case FigureData.const_52:
               break;
            case FigureData.const_111:
            case FigureData.const_135:
            case FigureData.const_133:
            case FigureData.const_143:
            case FigureData.const_137:
            case FigureData.const_134:
            case FigureData.CHEST_ACCESSORIES:
               _loc8_ = true;
         }
         if(_loc7_ != null)
         {
            _loc10_ = getPalette(_loc7_.paletteID);
            _loc12_ = figureData.getColourId(param2);
            for each(_loc13_ in _loc10_.colors)
            {
               _loc15_ = true;
               if(_loc13_.club)
               {
                  _loc15_ = var_852;
               }
               if(_loc13_.isSelectable && _loc15_)
               {
                  _loc16_ = new AvatarEditorColorItem(AvatarEditorView.var_1436.clone() as IWindowContainer,param1,_loc13_);
                  _loc4_.push(_loc16_);
                  if(_loc13_.id == _loc12_ && param2 != FigureData.const_52)
                  {
                     _loc11_ = _loc13_;
                  }
               }
            }
            if(_loc8_)
            {
               _loc17_ = _assets.getAssetByName("removeSelection") as BitmapDataAsset;
               _loc18_ = (_loc17_.content as BitmapData).clone();
               _loc6_ = new AvatarEditorGridItem(AvatarEditorView.var_1215.clone() as IWindowContainer,param1,null,null,false);
               _loc6_.iconImage = _loc18_;
               _loc3_.push(_loc6_);
            }
            _loc14_ = param2 != FigureData.const_52;
            for each(_loc5_ in _loc7_.partSets)
            {
               _loc19_ = false;
               _loc20_ = true;
               if(_loc5_.gender == FigureData.const_1130)
               {
                  _loc19_ = true;
               }
               else if(_loc5_.gender == gender)
               {
                  _loc19_ = true;
               }
               if(_loc5_.isClub)
               {
                  _loc20_ = var_852;
               }
               if(_loc5_.isSelectable && _loc19_ && _loc20_)
               {
                  _loc6_ = new AvatarEditorGridItem(AvatarEditorView.var_1215.clone() as IWindowContainer,param1,_loc5_,_loc11_,_loc14_);
                  _loc3_.push(_loc6_);
               }
            }
         }
         _loc3_.sort(method_9);
         _loc4_.sort(orderPaletteByClub);
         return new CategoryData(_loc3_,_loc4_);
      }
      
      public function get windowContext() : IWindowContainer
      {
         return var_357;
      }
      
      public function getCategoryWindowContainer(param1:String) : IWindowContainer
      {
         var _loc2_:IAvatarEditorCategoryModel = var_306.getValue(param1) as IAvatarEditorCategoryModel;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      private function orderPaletteByClub(param1:AvatarEditorColorItem, param2:AvatarEditorColorItem) : Number
      {
         var _loc3_:Number = param1.partColor == null ? -1 : Number(param1.partColor.club as Number);
         var _loc4_:Number = param2.partColor == null ? -1 : Number(param2.partColor.club as Number);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.partColor.index < param2.partColor.index)
         {
            return -1;
         }
         if(param1.partColor.index > param2.partColor.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return var_1016;
      }
      
      public function openEditor(param1:IWindowContainer = null) : Boolean
      {
         var urlString:String = null;
         var context:IWindowContainer = param1;
         if(!var_851)
         {
            init();
         }
         if(_view == null)
         {
            _view = new AvatarEditorView(this,_windowManager);
         }
         if(context != null)
         {
            context.addChild(_view.window);
         }
         else
         {
            if(var_357 == null)
            {
               var_357 = _windowManager.createWindow("avatarEditorContainer","",HabboWindowType.const_53,HabboWindowStyle.const_37,0 | 0,new Rectangle(0,0,2,2),null,0) as IWindowContainer;
               var_357.addChild(_view.window);
               var_357.center();
               var_357.visible = false;
            }
            var_357.visible = true;
         }
         _view.show();
         toggleAvatarEditorPage(AvatarEditorCategory.const_818);
         if(var_160 != null)
         {
            urlString = var_160.getKey("avatar.editor.url");
            try
            {
            }
            catch(e:Error)
            {
               Logger.log("Error occurred!");
            }
         }
         if(var_1029 != null)
         {
            var_1029.getWardrobe();
         }
         return false;
      }
      
      public function openCategory(param1:String) : void
      {
      }
      
      private function onAvatarRenderManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1016 = param2 as IAvatarRenderManager;
         (var_1016 as Component).events.addEventListener(AvatarRenderEvent.AVATAR_RENDER_READY,onAvatarRendererReady);
      }
      
      private function onInventoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_32 = param2 as IHabboInventory;
         (var_32 as Component).events.addEventListener(HabboInventoryHabboClubEvent.const_569,onHabboClubChanged);
      }
      
      private function onAvatarRendererReady(param1:Event = null) : void
      {
         var_850 = var_1016.getFigureData(AvatarType.const_118);
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _localization = param2 as IHabboLocalizationManager;
      }
      
      public function toggleAvatarEditorSubPage(param1:String) : void
      {
      }
      
      public function loadAvatarInEditor(param1:String, param2:String, param3:Boolean = false) : void
      {
         var _loc5_:* = null;
         switch(param2)
         {
            case FigureData.const_71:
            case "m":
            case "M":
               param2 = "null";
               break;
            case FigureData.const_77:
            case "f":
            case "F":
               param2 = "null";
         }
         var_852 = param3;
         var _loc4_:FigureData = var_577[param2];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.loadAvatarData(param1,param2);
         if(param2 != this.gender)
         {
            this.gender = param2;
         }
         for each(_loc5_ in var_306)
         {
            _loc5_.reset();
         }
         if(_view != null)
         {
            _view.updateAvatar();
         }
      }
      
      public function get configuration() : IHabboConfigurationManager
      {
         return var_160;
      }
   }
}
