package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class PetsCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      
      private static const const_1024:Array = new Array(16743226,16750435,16764339,16094464,16498012,16704690,15586304,16115545,16513201,8694111,11585939,14413767,6664599,9553845,12971486,8358322,10002885,13292268,10780600,12623573,14403561,12418717,14327229,15517403,14515069,15764368,16366271,11250603,13948116,16777215,14256481,14656129,15848130,14005087,14337152,16579283,15378351,8830016,15257125,9340985,8949607,6198292,8703620,9889626,8972045,12161285,13162269,8620113,12616503,8628101,15118118,15531929,9764857,11258085,15918540,13827840);
      
      private static const const_261:Array = new Array([16743226,16750435,16764339,16094464,16498012,16704690,15586304,16115545,16513201,8694111,11585939,14413767,6664599,9553845,12971486,8358322,10002885,13292268,10780600,12623573,14403561,12418717,14327229,15517403,14515069,15764368,16366271,11250603,13948116,16777215,14256481,14656129,15848130,14005087,14337152,15918540,15118118,15531929,9764857,11258085],[16743226,16750435,16764339,16094464,16498012,16704690,15586304,16115545,16513201,8694111,11585939,14413767,6664599,9553845,12971486,8358322,10002885,13292268,10780600,12623573,14403561,12418717,14327229,15517403,14515069,15764368,16366271,11250603,13948116,16777215,14256481,14656129,15848130,14005087,14337152,15918540,15118118,15531929,9764857,11258085],[16579283,15378351,8830016,15257125,9340985,8949607,6198292,8703620,9889626,8972045,12161285,13162269,8620113,12616503,8628101,13827840,9764857]);
      
      private static const const_718:Array = new Array(25,25,12);
      
      private static const const_1023:Array = new Array(25,25,1);
       
      
      private var var_613:int = 0;
      
      private var var_429:Boolean = false;
      
      private var var_218:int = -1;
      
      private var var_1119:int = 0;
      
      private var _name:String;
      
      private var var_877:Map;
      
      public function PetsCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      private function getPurchaseParameters() : String
      {
         if(_name == null || false)
         {
            page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.empty}",0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
            return "";
         }
         if(var_613 >= const_261[var_218].length)
         {
            return "";
         }
         var p:String = _name + String.fromCharCode(10) + addZeroPadding(String(var_1119),3) + String.fromCharCode(10) + addZeroPadding(const_261[var_218][var_613].toString(16).toUpperCase(),6);
         return p;
      }
      
      private function getRaceLocalizationKey(param1:int, param2:int) : String
      {
         return "pet.race." + param1 + "." + addZeroPadding(String(param2),3);
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_613 = param1.index;
         if(var_613 > const_261[var_218].length)
         {
            var_613 = 0;
         }
         updateImage();
      }
      
      private function getFigureString() : String
      {
         var _loc2_:int = var_1119;
         if(const_1023[var_218] < var_1119)
         {
            _loc2_ = 0;
         }
         var _loc3_:int = 25 * var_218 + (_loc2_ + 1);
         var _loc4_:int = const_1024.indexOf(const_261[var_218][var_613]);
         var _loc5_:String = "";
         _loc5_ += "phd-" + _loc3_ + "-" + (_loc4_ + 1);
         _loc5_ += ".pbd-" + _loc3_ + "-" + (_loc4_ + 1);
         return _loc5_ + (".ptl-" + _loc3_ + "-" + (_loc4_ + 1));
      }
      
      override public function init() : void
      {
         super.init();
         var_429 = false;
         var _loc1_:IWindow = window.findChildByName("ctlg_buy_button");
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onBuyButtonEvent);
         var _loc2_:ITextFieldWindow = window.findChildByName("name_input_text") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.addEventListener(WindowEvent.const_246,onTextWindowEvent);
         var_877 = new Map();
         var _loc3_:Array = new Array();
         var _loc4_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         if(page.offers.length == 0)
         {
            return;
         }
         var _loc5_:Offer = page.offers[0];
         var_218 = getPetTypeIndexFromProduct(_loc5_.localizationId);
         var _loc6_:int = 0;
         while(_loc6_ < const_718[var_218])
         {
            _loc3_.push(_loc4_.getKey(getRaceLocalizationKey(var_218,_loc6_),getRaceLocalizationKey(var_218,_loc6_)));
            _loc6_++;
         }
         var_877.add(var_218,_loc5_);
         var _loc7_:IDropMenuWindow = window.findChildByName("type_drop_menu") as IDropMenuWindow;
         if(_loc7_ == null)
         {
            return;
         }
         if(_loc3_.length > 1)
         {
            _loc7_.populate(_loc3_);
            _loc7_.selection = 0;
            _loc7_.procedure = onDropMenuEvent;
         }
         else
         {
            _loc7_.visible = false;
         }
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,onSelectProduct);
         events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX,onColourIndex);
         events.addEventListener(WidgetEvent.const_828,onApproveNameResult);
         _loc5_ = var_877.getWithIndex(0);
         if(_loc5_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc5_));
         }
         events.dispatchEvent(new CatalogWidgetColoursEvent(const_261[var_218],"ctlg_clr_27x22_1","ctlg_clr_27x22_2","ctlg_clr_27x22_3"));
      }
      
      private function onApproveNameResult(param1:CatalogWidgetApproveNameResultEvent) : void
      {
         var event:CatalogWidgetApproveNameResultEvent = param1;
         if(event == null || !var_429)
         {
            return;
         }
         var_429 = false;
         switch(event.result)
         {
            case 1:
               page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.length}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               return;
            case 2:
               page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.chars}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               return;
            case 3:
               page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.bobba}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               return;
            case 4:
               page.viewer.catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.taken}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
         }
         var p:String = getPurchaseParameters();
         if(p == "")
         {
            Logger.log("* Not enough information to buy a pet!");
            return;
         }
         Logger.log("* Will buy pet as " + p);
         (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(var_877.getWithIndex(0),page,p);
      }
      
      private function getPetTypeIndexFromProduct(param1:String) : int
      {
         if(param1.length == 0)
         {
            return 0;
         }
         return int(param1.charAt(param1.length - 1));
      }
      
      override public function dispose() : void
      {
         var_429 = false;
         super.dispose();
      }
      
      private function onBuyButtonEvent(param1:WindowEvent) : void
      {
         if(var_429)
         {
            Logger.log("* Cannot buy a pet, pending previous name approval.");
         }
         if(getPurchaseParameters() == "")
         {
            return;
         }
         var_429 = true;
         (page.viewer.catalog as HabboCatalog).approveName(_name,1);
      }
      
      private function addZeroPadding(param1:String, param2:int) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      public function onDropMenuEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == WindowEvent.const_51)
         {
            _loc3_ = IDropMenuWindow(param2).selection;
            if(_loc3_ >= const_718[var_218])
            {
               return;
            }
            var_1119 = _loc3_;
            updateImage();
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Offer = param1.offer;
         var _loc3_:IProductData = page.viewer.catalog.getProductData(_loc2_.localizationId);
         updateImage();
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(false)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         var _loc2_:IBitmapWrapperWindow = window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         if(_loc2_ == null || _loc2_.bitmap == null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,16777215);
         }
         _loc2_.bitmap.fillRect(_loc2_.bitmap.rect,16777215);
         var _loc4_:BitmapData = new BitmapData(param1.width * 2,param1.height * 2,true,16777215);
         var _loc5_:Point = new Point((_loc2_.width - _loc4_.width) / 2,(_loc2_.height - _loc4_.height) / 2);
         _loc4_.draw(param1,new Matrix(2,0,0,2));
         _loc2_.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc5_,null,null,true);
         _loc2_.invalidate();
      }
      
      private function onTextWindowEvent(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _name = _loc2_.text;
      }
      
      private function updateImage() : void
      {
         var _loc2_:* = null;
         var _loc1_:Offer = var_877.getWithIndex(0);
         if(_loc1_ == null)
         {
            return;
         }
         switch(var_218)
         {
            case 0:
               _loc2_ = "null";
               break;
            case 1:
               _loc2_ = "null";
               break;
            case 2:
               _loc2_ = "null";
         }
         var _loc3_:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createPetImage(getFigureString(),_loc2_,AvatarScaleType.const_66);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.appendAction(AvatarAction.const_924);
         _loc3_.setDirection(AvatarSetType.const_40,4);
         setPreviewImage(_loc3_.getImage(AvatarSetType.const_40));
         var _loc4_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         var _loc5_:ITextWindow = _window.findChildByName("ctlg_price_credits") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc1_.priceInCredits));
            _loc5_.caption = "${catalog.purchase.price.credits}";
         }
      }
   }
}
