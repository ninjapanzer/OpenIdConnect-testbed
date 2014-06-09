jQuery(function(){
  jQuery('.json_data').each(function(){
    text = jQuery(this).text();
    text = JSON.parse(text);
    console.log(text);
    jQuery(this).text(JSON.stringify(text,null, 2));
  });
});