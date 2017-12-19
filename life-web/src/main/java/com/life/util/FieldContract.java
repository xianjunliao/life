package com.life.util;

import java.text.SimpleDateFormat;

public class FieldContract {
    public static final String MSG_TYPE_TEXT = "text";
    public static final String MSG_TYPE_IMAGE = "image";
    public static final String MSG_TYPE_MUSIC = "music";
    public static final String MSG_TYPE_LOCATION = "location";
    public static final String MSG_TYPE_LINK = "link";
    //public static final String MSG_TYPE_IMAGE_TEXT = "news";
    //public static final String MSG_TYPE_EVENT = "event";
    public static final String MSG_TYPE_VOICE = "voice";
    public static final String MSG_TYPE_VIDEO = "video";

    public static final String ROOT = "xml";
    public static final String TO_USER_NAME = "ToUserName";
    public static final String FROM_USER_NAME = "FromUserName";
    public static final String CREATE_TIME = "CreateTime";
    public static final String MSG_TYPE = "MsgType";
    public static final String MSG_ID = "MsgId";
    public static final String CONTENT = "Content";
    public static final String FUNC_FLAG = "FuncFlag";
    public static final String PIC_URL = "PicUrl";
    public static final String TITLE = "Title";
    public static final String DESCRITION = "Description";
    public static final String URL = "Url";
    public static final String MUSIC_URL = "MusicUrl";
    public static final String HQ_MUSIC_URL = "HQMusicUrl";
    public static final String MUSIC = "Music";
    public static final String EVENT = "Event";
    public static final String EVENT_KEY = "EventKey";
    public static final String TICKET = "Ticket";
    public static final String LATITUDE = "Latitude";
    public static final String LONGITUDE = "Longitude";
    public static final String PRECISION = "Precision";
    public static final String LOCATION_X = "Location_X";
    public static final String LOCATION_Y = "Location_Y";
    public static final String SCALE = "Scale";
    public static final String LABEL = "Label";
    public static final String ARTICLE_COUNT = "ArticleCount";
    public static final String ARTICLES = "Articles";
    public static final String ITEM = "item";
    public static final String MEDIA_ID = "MediaId";
    public static final String FORMAT = "Format";
    public static final String RECOGNITION = "Recognition";
    public static final String THUMBMEDIA_ID = "ThumbMediaId";
    public static final String IMAGE = "Image";
    public static final String VOICE = "Voice";
    public static final String VIDEO = "Video";

    public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");
    //GET 获取ACCESS_TOKEN
    public static final String ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";
    //POST 创建自定义菜单
    public static final String MENU_CREATE_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=%s";
    //GET 查询已创建的自定义菜单
    public static final String MENU_GET_URL = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=%s";
    //GET 删除自定义菜单
    public static final String MENU_DELETE_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=%s";


    public static String TEXTXML = "<xml>"
            + "<ToUserName><![CDATA[%1$s]]></ToUserName>"
            + "<FromUserName><![CDATA[%2$s]]></FromUserName>"
            + "<CreateTime>%3$s</CreateTime>"
            + "<MsgType><![CDATA[text]]></MsgType>"
            + "<Content><![CDATA[%4$s]]></Content>" + "<FuncFlag>0</FuncFlag>"
            + "</xml>";


    public static String TEXTcustomerXML = "<xml>"
            + "<ToUserName><![CDATA[%1$s]]></ToUserName>"
            + "<FromUserName><![CDATA[%2$s]]></FromUserName>"
            + "<CreateTime>%3$s</CreateTime>"
            + "<MsgType><![CDATA[transfer_customer_service]]></MsgType>"
            + "</xml>";

    public static String IMAGEXML = "<xml>"
            + "<ToUserName><![CDATA[%1$s]]></ToUserName>"
            + "<FromUserName><![CDATA[%2$s]]></FromUserName>"
            + "<CreateTime>%3$s</CreateTime>"
            + "<MsgType><![CDATA[image]]></MsgType>" + "<Image>"
            + "<MediaId><![CDATA[%4$s]]></MediaId>" + "</Image>" + "</xml>";


    public static String VOICEXML = "<xml>"
            + "<ToUserName><![CDATA[%1$s]]></ToUserName>"
            + "<FromUserName><![CDATA[%2$s]]></FromUserName>"
            + "<CreateTime>%3$s</CreateTime>"
            + "<MsgType><![CDATA[voice]]></MsgType>" + "<Voice>"
            + "<MediaId><![CDATA[%4$s]]></MediaId>" + "</Voice>" + "</xml>";


    public static String NEWSSXML = "<xml>"
            + "<ToUserName><![CDATA[%1$s]]></ToUserName>"
            + "<FromUserName><![CDATA[%2$s]]></FromUserName>"
            + "<CreateTime>%3$s</CreateTime>"
            + "<MsgType><![CDATA[news]]></MsgType>"
            + "<ArticleCount>%4$s</ArticleCount>" + "<Articles>";

    public static String NEWSEXML = "</Articles>" + "</xml>";

    public static String ITEMXML = "<item>" + "<Title><![CDATA[%1$s]]></Title>"
            + "<Description><![CDATA[%2$s]]></Description>"
            + "<PicUrl><![CDATA[%3$s]]></PicUrl>"
            + "<Url><![CDATA[%4$s]]></Url>" + "</item>";


    public static String TEXTJSON = "{\"touser\":\"%1$s\",\"msgtype\":\"text\",\"text\":{\"content\":\"%2$s\"}}";

    public static String NEWSJSON = "{\"touser\":\"%1$s\",\"msgtype\":\"news\",\"news\":{\"articles\":[%2$s]}}";

    public static String NEWSARTJSON = "{\"title\":\"%1$s\", \"description\":\"%2$s\",\"url\":\"%3$s\",\"picurl\":\"%4$s\" }";


    public static String PICJSON = "{\"touser\":\"%1$s\",\"msgtype\":\"image\",\"image\":{\"media_id\":\"%2$s\"}}";

    public static String VOICEJSON = "{\"touser\":\"%1$s\",\"msgtype\":\"voice\",\"voice\":{\"media_id\":\"%2$s\"}}";

    public static String VIDEOJSON = "{\"touser\":\"%1$s\",\"msgtype\":\"video\",\"video\":{\"media_id\":\"%2$s\"," +
            "\"thumb_media_id\":\"%3$s\",\"title\":\"%4$s\",\"description\":\"%5$s\"}}";


}
