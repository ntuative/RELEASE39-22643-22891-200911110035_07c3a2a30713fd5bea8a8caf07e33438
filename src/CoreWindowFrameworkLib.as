package
{
   import com.sulake.core.window.Factory;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.WindowModel;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.renderer.ISkinLayout;
   import com.sulake.core.window.graphics.renderer.ISkinLayoutEntity;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.graphics.renderer.ISkinTemplate;
   import com.sulake.core.window.graphics.renderer.ISkinTemplateEntity;
   import com.sulake.core.window.graphics.renderer.ITextRenderer;
   import mx.core.SimpleApplication;
   
   public class CoreWindowFrameworkLib extends SimpleApplication
   {
      
      public static var ICoreWindowFrameworkLib:Class = ICoreWindowFrameworkLib;
      
      public static var ISkinLayout:Class = ISkinLayout;
      
      public static var ISkinRenderer:Class = ISkinRenderer;
      
      public static var Factory:Class = Factory;
      
      public static var WindowController:Class = WindowController;
      
      public static var ISkinTemplate:Class = ISkinTemplate;
      
      public static var IGraphicContext:Class = IGraphicContext;
      
      public static var ITextRenderer:Class = ITextRenderer;
      
      public static var ISkinLayoutEntity:Class = ISkinLayoutEntity;
      
      public static var IGraphicContextHost:Class = IGraphicContextHost;
      
      public static var WindowModel:Class = WindowModel;
      
      public static var ISkinTemplateEntity:Class = ISkinTemplateEntity;
       
      
      public function CoreWindowFrameworkLib()
      {
         super();
      }
   }
}
