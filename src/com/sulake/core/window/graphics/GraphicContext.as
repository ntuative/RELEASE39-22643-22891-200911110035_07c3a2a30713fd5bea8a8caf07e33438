package com.sulake.core.window.graphics
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.MorphShape;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class GraphicContext extends Sprite implements IGraphicContext
   {
      
      public static const GC_TYPE_DESKTOP:uint = 256;
      
      protected static var var_548:uint = 0;
      
      protected static var var_342:uint = 0;
      
      public static const GC_TYPE_TEXTFIELD:uint = 2;
      
      public static const const_1360:uint = 128;
      
      public static const const_1414:uint = 64;
      
      public static const GC_TYPE_CONTAINER:uint = 4;
      
      public static const GC_TYPE_UNKNOWN:uint = 0;
      
      public static const GC_TYPE_MORPH_SHAPE:uint = 16;
      
      public static const GC_TYPE_BITMAP:uint = 1;
      
      public static const GC_TYPE_SHAPE:uint = 8;
       
      
      protected var _disposed:Boolean = false;
      
      protected var var_545:Boolean;
      
      protected var var_1442:Boolean;
      
      protected var var_158:DisplayObjectContainer;
      
      public function GraphicContext(param1:String, param2:uint, param3:Rectangle)
      {
         var _loc4_:* = null;
         super();
         ++var_548;
         this.name = param1;
         this.mouseEnabled = false;
         this.doubleClickEnabled = false;
         this.x = param3.x;
         this.y = param3.y;
         var_1442 = true;
         var_545 = false;
         if(param3 == null)
         {
            param3 = new Rectangle(0,0,10,10);
         }
         switch(param2)
         {
            case GraphicContext.GC_TYPE_BITMAP:
               var_545 = true;
               setDisplayObject(new Bitmap());
               allocateDrawBuffer(param3.width,param3.height);
               break;
            case GraphicContext.GC_TYPE_TEXTFIELD:
               _loc4_ = new TextField();
               _loc4_.width = param3.width;
               _loc4_.height = param3.height;
               _loc4_.background = true;
               _loc4_.alwaysShowSelection = true;
               _loc4_.text = "";
               _loc4_.type = TextFieldType.INPUT;
               setDisplayObject(_loc4_);
               break;
            case GraphicContext.GC_TYPE_SHAPE:
               setDisplayObject(new Shape());
               break;
            case GraphicContext.GC_TYPE_MORPH_SHAPE:
               setDisplayObject(new MorphShape());
               break;
            case GraphicContext.GC_TYPE_CONTAINER:
               setDisplayObject(new Sprite());
               break;
            case GraphicContext.GC_TYPE_DESKTOP:
               break;
            case GraphicContext.GC_TYPE_UNKNOWN:
               break;
            default:
               throw new Error("Unsupported graphic context type: " + param2 + "!");
         }
      }
      
      public static function get numGraphicContexts() : uint
      {
         return var_548;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_342;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = stage.mouseX;
         param1.y = stage.mouseY;
      }
      
      public function addChildContextAt(param1:IGraphicContext, param2:int) : IGraphicContext
      {
         return setupChildContainer().addChildAt(param1 as DisplayObject,param2) as IGraphicContext;
      }
      
      protected function releaseDrawBuffer() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(var_545)
         {
            _loc1_ = getDisplayObject();
            if(_loc1_ is Bitmap)
            {
               _loc2_ = Bitmap(_loc1_).bitmapData;
               if(_loc2_ != null)
               {
                  var_342 -= _loc2_.width * _loc2_.height * 4;
                  _loc2_.dispose();
               }
            }
         }
      }
      
      public function swapChildContexts(param1:IGraphicContext, param2:IGraphicContext) : void
      {
         setupChildContainer().swapChildren(param1 as DisplayObject,param2 as DisplayObject);
      }
      
      public function removeChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return setupChildContainer().removeChild(DisplayObject(param1)) as IGraphicContext;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(parent != null)
            {
               parent.removeChild(this);
               parent = null;
            }
            while(numChildContexts > 0)
            {
               removeChildContextAt(0);
            }
            if(var_545)
            {
               releaseDrawBuffer();
            }
            if(var_158 != null)
            {
               while(false)
               {
                  var_158.removeChildAt(0);
               }
            }
            var_158 = null;
            while(numChildren > 0)
            {
               removeChildAt(0);
            }
            _disposed = true;
            --var_548;
         }
      }
      
      public function swapChildContextsAt(param1:int, param2:int) : void
      {
         setupChildContainer().swapChildrenAt(param1,param2);
      }
      
      public function set blend(param1:Number) : void
      {
         this.alpha = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function setupChildContainer() : DisplayObjectContainer
      {
         if(var_158 == null)
         {
            var_158 = new Sprite();
            var_158.name = this.name + " - Child Container";
            var_158.mouseEnabled = false;
            addChild(var_158);
         }
         return var_158;
      }
      
      public function removeChildContextAt(param1:int) : IGraphicContext
      {
         var _loc2_:IGraphicContext = setupChildContainer().getChildAt(param1) as IGraphicContext;
         return _loc2_ == null ? null : removeChildContext(_loc2_);
      }
      
      public function addChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return setupChildContainer().addChild(param1 as DisplayObject) as IGraphicContext;
      }
      
      protected function allocateDrawBuffer(param1:int, param2:int) : BitmapData
      {
         var displayObject:DisplayObject = null;
         var bitmap:BitmapData = null;
         var width:int = param1;
         var height:int = param2;
         if(var_545)
         {
            displayObject = getDisplayObject();
            if(displayObject is Bitmap)
            {
               bitmap = Bitmap(displayObject).bitmapData;
               if(bitmap != null)
               {
                  if(bitmap.width != width || bitmap.height != height)
                  {
                     var_342 -= bitmap.width * bitmap.height * 4;
                     bitmap.dispose();
                     bitmap = null;
                  }
               }
               if(bitmap == null && width > 0 && height > 0)
               {
                  try
                  {
                     bitmap = new BitmapData(width,height,var_1442,16777215);
                  }
                  catch(e:Error)
                  {
                     bitmap = new BitmapData(1,1,var_1442,16777215);
                  }
                  var_342 += bitmap.width * bitmap.height * 4;
               }
               Bitmap(displayObject).bitmapData = bitmap;
               return bitmap;
            }
         }
         return null;
      }
      
      public function getChildContextByName(param1:String) : IGraphicContext
      {
         return setupChildContainer().getChildByName(param1) as IGraphicContext;
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         var _loc2_:DisplayObject = getDisplayObject();
         param1.x = _loc2_.mouseX;
         param1.y = _loc2_.mouseY;
      }
      
      public function getDrawRegion() : Rectangle
      {
         return new Rectangle(this.x,this.y,this.width,this.height);
      }
      
      public function get blend() : Number
      {
         return this.alpha;
      }
      
      public function setDrawRegion(param1:Rectangle, param2:Boolean) : void
      {
         if(var_545 && param2)
         {
            allocateDrawBuffer(param1.width,param1.height);
         }
         x = param1.x;
         y = param1.y;
      }
      
      public function set parent(param1:DisplayObjectContainer) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         if(param1 != null)
         {
            param1.addChild(this);
         }
      }
      
      public function setChildContextIndex(param1:IGraphicContext, param2:int) : void
      {
         var current:int = 0;
         var temp:Array = null;
         var i:uint = 0;
         var child:IGraphicContext = param1;
         var index:int = param2;
         var dispObj:DisplayObject = child as DisplayObject;
         if(dispObj != null)
         {
            try
            {
               current = setupChildContainer().getChildIndex(dispObj);
            }
            catch(error:ArgumentError)
            {
               temp = new Array();
               i = 0;
               while(i < numChildContexts)
               {
                  temp.push(getChildContextAt(i));
                  i++;
               }
               throw new Error("Provided display object is not a child of this!");
            }
            if(index != current)
            {
               setupChildContainer().setChildIndex(dispObj,index);
            }
            return;
         }
         throw new Error("Provided child must implement IGraphicContext!");
      }
      
      public function showRedrawRegion(param1:Rectangle) : void
      {
         graphics.clear();
         graphics.lineStyle(1,4278255360);
         graphics.drawRect(0,0,width,height);
         if(param1 != null)
         {
            graphics.lineStyle(1,4278190335);
            graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      protected function removeChildContainer() : void
      {
         if(var_158 != null)
         {
            removeChild(var_158);
            var_158 = null;
         }
      }
      
      override public function toString() : String
      {
         return "[object GraphicContext name=\"" + name + "\"]";
      }
      
      public function setDisplayObject(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:* = null;
         if(numChildren > 0)
         {
            _loc2_ = removeChildAt(0);
         }
         addChildAt(param1,0);
         return _loc2_;
      }
      
      public function getChildContextIndex(param1:IGraphicContext) : int
      {
         return setupChildContainer().getChildIndex(DisplayObject(param1));
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getChildAt(0);
      }
      
      override public function set filters(param1:Array) : void
      {
         getDisplayObject().filters = param1;
      }
      
      public function get numChildContexts() : int
      {
         return var_158 != null ? 0 : 0;
      }
      
      override public function get filters() : Array
      {
         return getDisplayObject().filters;
      }
      
      public function getChildContextAt(param1:int) : IGraphicContext
      {
         return setupChildContainer().getChildAt(param1) as IGraphicContext;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         var _loc1_:* = null;
         if(var_545)
         {
            _loc1_ = getDisplayObject();
            if(_loc1_ != null)
            {
               return Bitmap(_loc1_).bitmapData;
            }
         }
         return null;
      }
   }
}
