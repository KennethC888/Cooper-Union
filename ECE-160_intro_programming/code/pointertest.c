









void strendcpy (char *dest, char *src, int num)
{

	int destlen = strlen(dest);
	int srclen = strlen(src); 

	for (int i =0; i< num; i++)
	{
		
		dest[destlen + i - num] = src[i];

	}

}


// THIS FUNCTION BUT WITH POINTERS

void strendcpy (char *dest, char *src, int num)
{

        int destlen = strlen(dest);
        int srclen = strlen(src);

	dest = dest + destlen - num; 

        for (int i =0; i< num; i++)                                                                                                                                 {

        	      *dest = *src;
		    dest ++;
		   src ++; 
		 // could also do *dest++ = *src++;   

        }

}   
