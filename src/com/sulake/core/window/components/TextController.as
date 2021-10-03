package com.sulake.core.window.components
{
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import com.sulake.core.window.graphics.WindowRedrawFlag;
   import com.sulake.core.window.utils.IMargins;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.TextMargins;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.Font;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.utils.Dictionary;
   
   public class TextController extends WindowController implements ITextWindow, ITextFieldContainer, ILocalizable
   {
      
      protected static var _PROPERTY_SETTER_TABLE:Dictionary;
      
      protected static var var_2111:Rectangle = new Rectangle();
       
      
      protected var var_199:Boolean;
      
      protected var var_71:TextMargins;
      
      protected var var_468:String = "none";
      
      protected var var_547:Number;
      
      protected var var_340:Number;
      
      protected var _field:TextField;
      
      protected var var_664:Boolean = false;
      
      public function TextController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         var_71 = new TextMargins(0,0,0,0,setTextMargins);
         var_199 = false;
         var_547 = 0;
         var_340 = 0;
         if(_field == null)
         {
            _field = new TextField();
            _field.width = param7.width;
            _field.height = param7.height;
            _field.mouseWheelEnabled = false;
         }
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         if(true)
         {
            _field.width = param7.width;
            _field.height = param7.height;
         }
         if(param2 != "")
         {
            text = param2;
         }
      }
      
      private static function setFontSize(param1:TextController, param2:uint) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.size = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setGridFitType(param1:TextController, param2:String) : void
      {
         param1._field.gridFitType = param2;
         param1.refreshTextImage();
      }
      
      private static function setMarginTop(param1:TextController, param2:int) : void
      {
         param1.margins.top = param2;
      }
      
      private static function setBold(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.bold = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setSpacing(param1:TextController, param2:Number) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.letterSpacing = param2;
         var _loc4_:TextFormat = new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading);
         _loc4_.letterSpacing = param2;
         param1.setTextFormat(_loc4_);
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setCondenseWhite(param1:TextController, param2:Boolean) : void
      {
         param1._field.condenseWhite = param2;
         param1.refreshTextImage();
      }
      
      private static function setMarginRight(param1:TextController, param2:int) : void
      {
         param1.margins.right = param2;
      }
      
      private static function setDisplayAsPassword(param1:TextController, param2:Boolean) : void
      {
         param1._field.displayAsPassword = param2;
         param1.refreshTextImage();
      }
      
      private static function setFontFace(param1:TextController, param2:String) : void
      {
         var _loc5_:* = null;
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.font = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1._field.embedFonts = false;
         var _loc4_:Array = Font.enumerateFonts(false);
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.fontName == param2)
            {
               param1._field.embedFonts = true;
               break;
            }
         }
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setKerning(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.kerning = param2;
         var _loc4_:TextFormat = new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading);
         _loc4_.kerning = param2;
         param1.setTextFormat(_loc4_);
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setAutoSize(param1:TextController, param2:String) : void
      {
         param1.var_468 = param2;
         param1._field.autoSize = param2 != TextFieldAutoSize.NONE ? "null" : TextFieldAutoSize.NONE;
         param1.refreshTextImage();
      }
      
      private static function setThickness(param1:TextController, param2:Number) : void
      {
         param1._field.thickness = param2;
         param1.refreshTextImage();
      }
      
      private static function setBorderColor(param1:TextController, param2:uint) : void
      {
         param1._field.borderColor = param2;
         param1.refreshTextImage();
      }
      
      private static function setTextColor(param1:TextController, param2:uint) : void
      {
         param1._field.textColor = param2;
         param1.refreshTextImage();
      }
      
      private static function setMarginLeft(param1:TextController, param2:int) : void
      {
         param1.margins.left = param2;
      }
      
      private static function setSelectable(param1:TextController, param2:Boolean) : void
      {
         param1._field.selectable = param2;
      }
      
      private static function setTextMarginMap(param1:TextController, param2:Map) : void
      {
         param1.var_71.dispose();
         param1.var_71 = new TextMargins(int(param2["left"]),int(param2["top"]),int(param2["right"]),int(param2["bottom"]),param1.setTextMargins);
         param1.refreshTextImage();
      }
      
      private static function setDefaultTextFormat(param1:TextController, param2:TextFormat) : void
      {
         param1._field.defaultTextFormat = param2;
         param1.refreshTextImage();
      }
      
      private static function setTextBackgroundColor(param1:TextController, param2:uint) : void
      {
         param1.color = param2;
      }
      
      private static function setMouseWheelEnabled(param1:TextController, param2:Boolean) : void
      {
         param1._field.mouseWheelEnabled = param2;
      }
      
      private static function setMaxChars(param1:TextController, param2:int) : void
      {
         param1._field.maxChars = param2;
         param1.refreshTextImage();
      }
      
      private static function setMultiline(param1:TextController, param2:Boolean) : void
      {
         param1._field.multiline = param2;
         param1.refreshTextImage();
      }
      
      private static function setUnderline(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.underline = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setAntiAliasType(param1:TextController, param2:String) : void
      {
         param1._field.antiAliasType = param2;
         param1.refreshTextImage();
      }
      
      private static function setBorder(param1:TextController, param2:Boolean) : void
      {
         param1._field.border = param2;
         param1.refreshTextImage();
      }
      
      private static function setWordWrap(param1:TextController, param2:Boolean) : void
      {
         param1._field.wordWrap = param2;
         param1.refreshTextImage();
      }
      
      private static function setStyleSheet(param1:TextController, param2:Object) : void
      {
         if(param2 is StyleSheet)
         {
            param1._field.styleSheet = StyleSheet(param2);
         }
         else if(param2 is String)
         {
            param1._field.styleSheet.parseCSS(unescape(String(param2)));
         }
         param1.refreshTextImage();
      }
      
      private static function setItalic(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.italic = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
      }
      
      private static function setEmbedFonts(param1:TextController, param2:Boolean) : void
      {
         param1._field.embedFonts = param2;
      }
      
      private static function setHtmlText(param1:TextController, param2:String) : void
      {
         param1._field.htmlText = param2;
         param1.refreshTextImage();
      }
      
      private static function setMarginBottom(param1:TextController, param2:int) : void
      {
         param1.margins.bottom = param2;
      }
      
      private static function setTextBackground(param1:TextController, param2:Boolean) : void
      {
         param1.background = param2;
      }
      
      private static function setAlwaysShowSelection(param1:TextController, param2:Boolean) : void
      {
         param1._field.alwaysShowSelection = param2;
      }
      
      private static function setSharpness(param1:TextController, param2:Number) : void
      {
         param1._field.sharpness = param2;
         param1.refreshTextImage();
      }
      
      public function replaceText(param1:int, param2:int, param3:String) : void
      {
         _field.replaceText(param1,param2,param3);
         refreshTextImage();
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(var_547 * maxScrollH,var_340 * maxScrollV,width,height);
      }
      
      public function set kerning(param1:Boolean) : void
      {
         setKerning(this,param1);
      }
      
      override public function dispose() : void
      {
         if(var_664)
         {
            context.removeLocalizationListener(var_229,this);
         }
         if(var_71 != null)
         {
            var_71.dispose();
            var_71 = null;
         }
         _field = null;
         super.dispose();
      }
      
      public function get border() : Boolean
      {
         return _field.border;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return _field.styleSheet;
      }
      
      public function get scrollStepH() : Number
      {
         return 10;
      }
      
      public function get italic() : Boolean
      {
         return _field.defaultTextFormat.italic;
      }
      
      public function get textColor() : uint
      {
         return _field.textColor;
      }
      
      public function getFirstCharInParagraph(param1:int) : int
      {
         return _field.getFirstCharInParagraph(param1);
      }
      
      public function get textBackground() : Boolean
      {
         return background;
      }
      
      public function get scrollStepV() : Number
      {
         return 0 / 0;
      }
      
      public function get spacing() : Number
      {
         return Number(_field.defaultTextFormat.letterSpacing);
      }
      
      public function set scrollH(param1:Number) : void
      {
         var_547 = param1;
         _field.scrollH = var_547 * Number(_field.maxScrollH);
         refreshTextImage();
      }
      
      public function get autoSize() : String
      {
         return var_468;
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(param1 > var_340)
         {
            var_340 = param1;
            _field.scrollV = Math.max(_field.scrollV,param1 * 0 + 1);
            refreshTextImage();
         }
         else if(param1 < var_340)
         {
            var_340 = param1;
            _field.scrollV = Math.min(_field.scrollV,param1 * 0 - 1);
            refreshTextImage();
         }
      }
      
      public function set border(param1:Boolean) : void
      {
         setBorder(this,param1);
      }
      
      public function set text(param1:String) : void
      {
         if(var_664)
         {
            context.removeLocalizationListener(var_229,this);
            var_664 = false;
         }
         var_229 = param1;
         if(var_229.charAt(0) == "$" && var_229.charAt(1) == "{")
         {
            context.registerLocalizationListener(var_229.slice(2,var_229.indexOf("}")),this);
            var_664 = true;
         }
         else if(_field != null)
         {
            _field.text = var_229;
            refreshTextImage();
         }
      }
      
      public function set styleSheet(param1:StyleSheet) : void
      {
         setStyleSheet(this,param1);
      }
      
      public function get selectable() : Boolean
      {
         return _field.selectable;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
      }
      
      public function set italic(param1:Boolean) : void
      {
         setItalic(this,param1);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_PROPERTY_SETTER_TABLE == null)
         {
            _PROPERTY_SETTER_TABLE = createPropertySetterTable();
         }
         var _loc2_:uint = param1.length;
         var_199 = true;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1[_loc5_] as PropertyStruct;
            _loc4_ = _PROPERTY_SETTER_TABLE[_loc3_.key];
            if(_loc4_ != null)
            {
               _loc4_(this,_loc3_.value);
            }
            _loc5_++;
         }
         var_199 = false;
         super.properties = param1;
         refreshTextImage();
      }
      
      public function get antiAliasType() : String
      {
         return _field.antiAliasType;
      }
      
      override public function set background(param1:Boolean) : void
      {
         super.background = param1;
         _field.background = param1;
         refreshTextImage();
      }
      
      public function set textColor(param1:uint) : void
      {
         setTextColor(this,param1);
      }
      
      public function get wordWrap() : Boolean
      {
         return _field.wordWrap;
      }
      
      public function set textBackground(param1:Boolean) : void
      {
         setTextBackground(this,param1);
      }
      
      public function set scrollStepV(param1:Number) : void
      {
      }
      
      public function get bottomScrollV() : int
      {
         return _field.bottomScrollV;
      }
      
      public function set sharpness(param1:Number) : void
      {
         setSharpness(this,param1);
      }
      
      public function getLineIndexOfChar(param1:int) : int
      {
         return _field.getLineIndexOfChar(param1);
      }
      
      public function get bold() : Boolean
      {
         return _field.defaultTextFormat.bold;
      }
      
      public function set spacing(param1:Number) : void
      {
         setSpacing(this,param1);
      }
      
      public function get margins() : IMargins
      {
         return var_71;
      }
      
      public function get borderColor() : uint
      {
         return _field.borderColor;
      }
      
      public function set fontFace(param1:String) : void
      {
         setFontFace(this,param1);
      }
      
      public function get textWidth() : Number
      {
         return _field.textWidth;
      }
      
      public function set autoSize(param1:String) : void
      {
         setAutoSize(this,param1);
      }
      
      public function get embedFonts() : Boolean
      {
         return _field.embedFonts;
      }
      
      public function get defaultTextFormat() : TextFormat
      {
         return _field.defaultTextFormat;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         _field.selectable = param1;
      }
      
      public function get multiline() : Boolean
      {
         return _field.multiline;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         setDisplayAsPassword(this,param1);
      }
      
      public function getLineText(param1:int) : String
      {
         return _field.getLineText(param1);
      }
      
      public function get textHeight() : Number
      {
         return _field.textHeight;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         _field.backgroundColor = param1;
         refreshTextImage();
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(!var_199)
         {
            if(param2.type == WindowNotifyEvent.const_232)
            {
               refreshTextImage();
            }
         }
         return super.update(param1,param2);
      }
      
      public function get gridFitType() : String
      {
         return _field.gridFitType;
      }
      
      public function set antiAliasType(param1:String) : void
      {
         setAntiAliasType(this,param1);
      }
      
      public function get underline() : Boolean
      {
         return _field.defaultTextFormat.underline;
      }
      
      public function setTextMargins(param1:IMargins) : void
      {
         if(param1 != var_71)
         {
            var_71.dispose();
            var_71 = new TextMargins(param1.left,param1.top,param1.right,param1.bottom,setTextMargins);
         }
         refreshTextImage();
      }
      
      public function get maxChars() : int
      {
         return _field.maxChars;
      }
      
      private function createPropertySetterTable() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["antialias_type"] = setAntiAliasType;
         _loc1_["always_show_selection"] = setAlwaysShowSelection;
         _loc1_["auto_size"] = setAutoSize;
         _loc1_["background"] = setTextBackground;
         _loc1_["background_color"] = setTextBackgroundColor;
         _loc1_["bold"] = setBold;
         _loc1_["border"] = setBorder;
         _loc1_["border_color"] = setBorderColor;
         _loc1_["condense_white"] = setCondenseWhite;
         _loc1_["display_as_password"] = setDisplayAsPassword;
         _loc1_["default_text_format"] = setDefaultTextFormat;
         _loc1_["embed_fonts"] = setEmbedFonts;
         _loc1_["font_face"] = setFontFace;
         _loc1_["font_size"] = setFontSize;
         _loc1_["grid_fit_type"] = setGridFitType;
         _loc1_["html_text"] = setHtmlText;
         _loc1_["italic"] = setItalic;
         _loc1_["kerning"] = setKerning;
         _loc1_["max_chars"] = setMaxChars;
         _loc1_["mouse_wheel_enabled"] = setMouseWheelEnabled;
         _loc1_["multiline"] = setMultiline;
         _loc1_["selectable"] = setSelectable;
         _loc1_["spacing"] = setSpacing;
         _loc1_["sharpness"] = setSharpness;
         _loc1_["style_sheet"] = setStyleSheet;
         _loc1_["text_color"] = setTextColor;
         _loc1_["thickness"] = setThickness;
         _loc1_["underline"] = setUnderline;
         _loc1_["word_wrap"] = setWordWrap;
         _loc1_["margin_left"] = setMarginLeft;
         _loc1_["margin_top"] = setMarginTop;
         _loc1_["margin_right"] = setMarginRight;
         _loc1_["margin_bottom"] = setMarginBottom;
         _loc1_["margins"] = setTextMarginMap;
         return _loc1_;
      }
      
      public function get length() : int
      {
         return _field.length;
      }
      
      public function set thickness(param1:Number) : void
      {
         setThickness(this,param1);
      }
      
      public function get fontSize() : uint
      {
         return _field.defaultTextFormat.size == null ? 12 : uint(uint(_field.defaultTextFormat.size));
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         setWordWrap(this,param1);
      }
      
      public function getLineMetrics(param1:int) : TextLineMetrics
      {
         return _field.getLineMetrics(param1);
      }
      
      public function set htmlText(param1:String) : void
      {
         setHtmlText(this,param1);
      }
      
      public function set bold(param1:Boolean) : void
      {
         setBold(this,param1);
      }
      
      public function get kerning() : Boolean
      {
         return _field.defaultTextFormat.kerning;
      }
      
      public function get maxScrollH() : int
      {
         return _field.maxScrollH;
      }
      
      public function get scrollH() : Number
      {
         return var_547;
      }
      
      public function get numLines() : int
      {
         return _field.numLines;
      }
      
      public function get maxScrollV() : int
      {
         return Math.max(0 - height,0);
      }
      
      public function getImageReference(param1:String) : DisplayObject
      {
         return _field.getImageReference(param1);
      }
      
      public function get scrollV() : Number
      {
         return var_340;
      }
      
      public function set localization(param1:String) : void
      {
         if(param1 != null && _field != null)
         {
            _field.text = param1;
            refreshTextImage();
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(new PropertyStruct("font_face",defaultTextFormat.font,PropertyStruct.const_233,true));
         _loc1_.push(new PropertyStruct("font_size",defaultTextFormat.size,PropertyStruct.const_1216,true));
         _loc1_.push(new PropertyStruct("text_color",_field.textColor,PropertyStruct.const_398,true));
         _loc1_.push(new PropertyStruct("antialias_type",_field.antiAliasType,PropertyStruct.const_233,true));
         _loc1_.push(new PropertyStruct("always_show_selection",_field.alwaysShowSelection,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("border",_field.border,PropertyStruct.const_58,false));
         _loc1_.push(new PropertyStruct("border_color",_field.borderColor,PropertyStruct.const_398,true));
         _loc1_.push(new PropertyStruct("condense_white",_field.condenseWhite,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("display_as_password",_field.displayAsPassword,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("embed_fonts",_field.embedFonts,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("grid_fit_type",_field.gridFitType,PropertyStruct.const_233,true));
         _loc1_.push(new PropertyStruct("max_chars",_field.maxChars,PropertyStruct.const_85,true));
         _loc1_.push(new PropertyStruct("mouse_wheel_enabled",_field.mouseWheelEnabled,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("multiline",_field.multiline,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("sharpness",_field.sharpness,PropertyStruct.const_660,true));
         _loc1_.push(new PropertyStruct("style_sheet",_field.styleSheet,PropertyStruct.const_233,false));
         _loc1_.push(new PropertyStruct("thickness",_field.thickness,PropertyStruct.const_660,true));
         _loc1_.push(new PropertyStruct("word_wrap",_field.wordWrap,PropertyStruct.const_58,true));
         _loc1_.push(new PropertyStruct("margin_left",var_71.left,PropertyStruct.const_85,true));
         _loc1_.push(new PropertyStruct("margin_top",var_71.top,PropertyStruct.const_85,true));
         _loc1_.push(new PropertyStruct("margin_right",var_71.right,PropertyStruct.const_85,true));
         _loc1_.push(new PropertyStruct("margin_bottom",var_71.bottom,PropertyStruct.const_85,true));
         _loc1_.push(new PropertyStruct("auto_size",var_468,PropertyStruct.const_233,var_468 != TextFieldAutoSize.NONE));
         _loc1_.push(new PropertyStruct("bold",_field.defaultTextFormat.bold != false,PropertyStruct.const_58,_field.defaultTextFormat.bold != false));
         _loc1_.push(new PropertyStruct("italic",_field.defaultTextFormat.italic != false,PropertyStruct.const_58,_field.defaultTextFormat.italic != false));
         _loc1_.push(new PropertyStruct("underline",_field.defaultTextFormat.underline != false,PropertyStruct.const_58,_field.defaultTextFormat.underline != false));
         _loc1_.push(new PropertyStruct("kerning",_field.defaultTextFormat.kerning != false,PropertyStruct.const_58,_field.defaultTextFormat.kerning != false));
         _loc1_.push(new PropertyStruct("spacing",_field.defaultTextFormat.letterSpacing,PropertyStruct.const_660,_field.defaultTextFormat.letterSpacing != 0));
         return _loc1_;
      }
      
      public function get text() : String
      {
         return _field != null ? "null" : "";
      }
      
      public function set borderColor(param1:uint) : void
      {
         setBorderColor(this,param1);
      }
      
      public function getCharBoundaries(param1:int) : Rectangle
      {
         return _field.getCharBoundaries(param1);
      }
      
      public function get sharpness() : Number
      {
         return _field.sharpness;
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         setDefaultTextFormat(this,param1);
      }
      
      public function get fontFace() : String
      {
         return _field.defaultTextFormat.font;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return _field.displayAsPassword;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         setMultiline(this,param1);
      }
      
      override public function clone() : IWindow
      {
         var _loc1_:TextController = super.clone() as TextController;
         var _loc2_:TextField = _loc1_._field;
         _loc2_.backgroundColor = color;
         _loc2_.background = background;
         _loc1_.var_547 = var_547;
         _loc1_.var_340 = var_340;
         _loc1_.var_71 = var_71.clone(_loc1_.setTextMargins);
         _loc1_.var_468 = var_468;
         _loc1_.var_664 = var_664;
         return _loc1_;
      }
      
      public function set embedFonts(param1:Boolean) : void
      {
         setEmbedFonts(this,param1);
      }
      
      public function appendText(param1:String) : void
      {
         _field.appendText(param1);
         refreshTextImage();
      }
      
      public function get thickness() : Number
      {
         return _field.thickness;
      }
      
      public function getLineIndexAtPoint(param1:Number, param2:Number) : int
      {
         return _field.getLineIndexAtPoint(param1,param2);
      }
      
      public function get htmlText() : String
      {
         return _field.htmlText;
      }
      
      public function getTextFormat(param1:int = -1, param2:int = -1) : TextFormat
      {
         return _field.getTextFormat(param1,param2);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return new Rectangle(0,0,maxScrollH + width,maxScrollV + height);
      }
      
      public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
      {
         _field.setTextFormat(param1,param2,param3);
         refreshTextImage();
      }
      
      public function set gridFitType(param1:String) : void
      {
         setGridFitType(this,param1);
      }
      
      protected function refreshTextImage() : void
      {
         if(var_199)
         {
            return;
         }
         var_199 = true;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0 - _loc1_;
         var _loc4_:int = 0 - _loc2_;
         var _loc5_:int = Math.floor(_field.width) + (!true ? 1 : 0);
         var _loc6_:int = Math.floor(_field.height) + (!true ? 1 : 0);
         var _loc7_:Boolean = false;
         if(_loc5_ != _loc3_)
         {
            if(var_468 == TextFieldAutoSize.LEFT)
            {
               setRectangle(var_22.x,var_22.y,_loc5_ + _loc1_,Math.floor(_field.height) + _loc2_);
               _loc7_ = true;
            }
            else if(var_468 == TextFieldAutoSize.RIGHT)
            {
               setRectangle(var_22.x,var_22.y,_loc5_ + _loc1_,Math.floor(_field.height) + _loc2_);
               _loc7_ = true;
            }
            else if(var_468 != TextFieldAutoSize.CENTER)
            {
               _field.width = _loc3_ - (!true ? 1 : 0);
               _field.height = _loc4_ - (!true ? 1 : 0);
            }
         }
         if(_field.height + (!true ? 1 : 0) < _loc4_)
         {
            _field.height = _loc4_ - (!true ? 1 : 0);
         }
         else if(_field.height + (!true ? 1 : 0) > _loc4_)
         {
            if(var_468 != TextFieldAutoSize.NONE)
            {
               setRectangle(var_22.x,var_22.y,_loc5_ + _loc1_,Math.floor(_field.height) + _loc2_);
               _loc7_ = true;
            }
         }
         var_199 = false;
         _context.invalidate(this,var_22,WindowRedrawFlag.const_70);
         if(!_loc7_)
         {
            dispatchEvent(new WindowEvent(WindowEvent.const_46,this,null));
         }
      }
      
      public function set underline(param1:Boolean) : void
      {
         setUnderline(this,param1);
      }
      
      protected function parseVariableSet(param1:XML) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 != null)
         {
            if(_PROPERTY_SETTER_TABLE == null)
            {
               _PROPERTY_SETTER_TABLE = createPropertySetterTable();
            }
            _loc4_ = new Map();
            XMLVariableParser.parseVariableList(param1.children(),_loc4_);
            var_199 = true;
            for(_loc2_ in _loc4_)
            {
               _loc3_ = _PROPERTY_SETTER_TABLE[_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_(this,_loc4_[_loc2_]);
               }
            }
            var_199 = false;
         }
      }
      
      public function getLineOffset(param1:int) : int
      {
         return _field.getLineOffset(param1);
      }
      
      public function set maxChars(param1:int) : void
      {
         setMaxChars(this,param1);
      }
      
      public function getParagraphLength(param1:int) : int
      {
         return _field.getParagraphLength(param1);
      }
      
      override public function set caption(param1:String) : void
      {
         text = param1;
      }
      
      public function get textField() : TextField
      {
         return _field;
      }
      
      public function set textBackgroundColor(param1:uint) : void
      {
         setTextBackgroundColor(this,param1);
      }
      
      public function getCharIndexAtPoint(param1:Number, param2:Number) : int
      {
         return _field.getCharIndexAtPoint(param1,param2);
      }
      
      public function set fontSize(param1:uint) : void
      {
         setFontSize(this,param1);
      }
      
      public function get textBackgroundColor() : uint
      {
         return color;
      }
      
      public function getLineLength(param1:int) : int
      {
         return _field.getLineLength(param1);
      }
   }
}
