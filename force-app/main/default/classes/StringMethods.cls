public class StringMethods {
    public static void string()
    {
        String str='Hyderabad';
        String res = str.substring(0, 3);
        System.debug('res is::'+res);
        System.debug(str.length());
        System.debug(str.indexOf('a'));
        System.debug(str.charAt(5));
        System.debug(str.toLowerCase());
       // System.debug(isBlank(str));
        System.debug(str.split('r', 2));
        System.debug(str.trim());
    }

    public static void reverse()
    {
        String str='Hyderabad';String str1='';
        System.debug(str.reverse());
        for(Integer i=str.length()-1;i>=0;i--)
        {
             str1+=str.substring(i,i+1);
             
        }System.debug(str1);
    }

}