.headers off
.mode csv
select id,section,publish_date,format_type,slug,featured_image,title,description,content from mae_posts where status=2 order by publish_date;
