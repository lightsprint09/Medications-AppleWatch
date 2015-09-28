%%
% ----------------------------------------------------------------------------
% "THE BEER-WARE LICENSE" (Revision 42):
% <sebastian.rauh@hs-heilbronn.de/michael.bauer@hs-heilbronn.de> wrote this 
% file. As long as you retain this notice you can do whatever you want with 
% this stuff. If we meet some day, and you think this stuff is worth it, you 
% can buy us a beer in return. 
% Michael Lukas Bauer, Sebastian Felix Rauh
% ----------------------------------------------------------------------------
%%

for generating a glossary it's necessary to download the latest version of perl. 
Make shure there's an entry in the path environment variable!

Afterwords you have to eather use the command makeglossaries "filename without extension" (eg. "makeglossaries
 file" for file.tex) or create a user command in texmaker (or the latex editor of your choice). Therefor you 
just choose a name (e.g. makeglossaries) and then add the command makeglossaries %. "%" refers to the 
currently opened file.

More information can be found in the internet (if it still exists). Good entry: 
http://en.wikibooks.org/w/index.php?title=LaTeX/Glossary&stable=0#Compile_glossary_-_In_windows_with_texmaker