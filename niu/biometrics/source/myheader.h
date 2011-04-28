/* field data is used to obtain different attributes of an image */
/* using the tiff lib functions */
struct field_data
{
	int width;
	int height;
	uint16  bitssample;
	uint16 sampleperpixel;
	uint32 rowsperstrip;
	float x_res;
	float y_res;
};	

/* defines u_char, to resolve any conflicts with Linux distros */
/* as well as assit in coding in that environment */
/*  ie.  using u_char was giving me issues while coding on my Linxu 
 *  box, so i typedefed it.  */
typedef unsigned char u_char;
