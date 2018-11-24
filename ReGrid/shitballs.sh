#./ReGrid4.3.sh 20 0.08 50x50 file:///home/pandela/Videos/W2.mp4 640x360 -br
FFMPREG -ss 00:01:00 -i 'file:///home/pandela/Videos/W2.mp4' -lavfi \
"nullsrc=d=0.0001:s=640x360,lutrgb=0[null];[0:v]scale=640x360,setsar=1/1[v];
[null][v]concat[in1];[in1]scale=50x50,split=outputs=20[1][2][3][4][5][6][7][8][9][10][11][12][13][14][15][16][17][18][19][20]; 
[20]setpts='if(eq(N,0),PTS,PTS+0.08/TB)'[20]; \
[19]setpts='if(eq(N,0),PTS,PTS+0.16/TB)'[19]; \
[18]setpts='if(eq(N,0),PTS,PTS+0.24/TB)'[18]; \
[17]setpts='if(eq(N,0),PTS,PTS+0.32/TB)'[17]; \
[16]setpts='if(eq(N,0),PTS,PTS+0.40/TB)'[16]; \
[15]setpts='if(eq(N,0),PTS,PTS+0.48/TB)'[15]; \
[14]setpts='if(eq(N,0),PTS,PTS+0.56/TB)'[14]; \
[13]setpts='if(eq(N,0),PTS,PTS+0.64/TB)'[13]; \
[12]setpts='if(eq(N,0),PTS,PTS+0.72/TB)'[12]; \
[11]setpts='if(eq(N,0),PTS,PTS+0.80/TB)'[11]; \
[10]setpts='if(eq(N,0),PTS,PTS+0.88/TB)'[10]; \
[9]setpts='if(eq(N,0),PTS,PTS+0.96/TB)'[9]; \
[8]setpts='if(eq(N,0),PTS,PTS+01.04/TB)'[8]; \
[7]setpts='if(eq(N,0),PTS,PTS+01.12/TB)'[7]; \
[6]setpts='if(eq(N,0),PTS,PTS+01.20/TB)'[6]; \
[5]setpts='if(eq(N,0),PTS,PTS+01.28/TB)'[5]; \
[4]setpts='if(eq(N,0),PTS,PTS+01.36/TB)'[4]; \
[3]setpts='if(eq(N,0),PTS,PTS+01.44/TB)'[3]; \
[2]setpts='if(eq(N,0),PTS,PTS+01.52/TB)'[2]; \
[1]setpts='if(eq(N,0),PTS,PTS+01.60/TB)'[1]; \
[1][2][3][4][5][6][7][8][9][10][11][12][13][14][15][16][17][18][19][20]vstack=inputs=20[a];[a]split=outputs=20[21][22][23][24][25][26][27][28][29][30][31][32][33][34][35][36][37][38][39][40]; \
[40]setpts='if(eq(N,0),PTS,PTS+0.08/TB)'[40]; \
[39]setpts='if(eq(N,0),PTS,PTS+0.16/TB)'[39]; \
[38]setpts='if(eq(N,0),PTS,PTS+0.24/TB)'[38]; \
[37]setpts='if(eq(N,0),PTS,PTS+0.32/TB)'[37]; \
[36]setpts='if(eq(N,0),PTS,PTS+0.40/TB)'[36]; \
[35]setpts='if(eq(N,0),PTS,PTS+0.48/TB)'[35]; \
[34]setpts='if(eq(N,0),PTS,PTS+0.56/TB)'[34]; \
[33]setpts='if(eq(N,0),PTS,PTS+0.64/TB)'[33]; \
[32]setpts='if(eq(N,0),PTS,PTS+0.72/TB)'[32]; \
[31]setpts='if(eq(N,0),PTS,PTS+0.80/TB)'[31]; \
[30]setpts='if(eq(N,0),PTS,PTS+0.88/TB)'[30]; \
[29]setpts='if(eq(N,0),PTS,PTS+0.96/TB)'[29]; \
[28]setpts='if(eq(N,0),PTS,PTS+01.04/TB)'[28]; \
[27]setpts='if(eq(N,0),PTS,PTS+01.12/TB)'[27]; \
[26]setpts='if(eq(N,0),PTS,PTS+01.20/TB)'[26]; \
[25]setpts='if(eq(N,0),PTS,PTS+01.28/TB)'[25]; \
[24]setpts='if(eq(N,0),PTS,PTS+01.36/TB)'[24]; \
[23]setpts='if(eq(N,0),PTS,PTS+01.44/TB)'[23]; \
[22]setpts='if(eq(N,0),PTS,PTS+01.52/TB)'[22]; \
[21]setpts='if(eq(N,0),PTS,PTS+01.60/TB)'[21]; \
[21][22][23][24][25][26][27][28][29][30][31][32][33][34][35][36][37][38][39][40]hstack=inputs=20,scale=640x360,setsar=1/1[b]; \
aevalsrc=0:d=0.16[silence];[silence][0:a]concat=v=0:a=1[c]; \
[b]trim=start=0.16:duration=0[out];[c]atrim=start=0.16:duration=0[out2]" \
-map "[out]" -map "[out2]" -f nut -c:v mjpeg -c:a pcm_u8 -q:v 0 -s 640x360  testme.nut
FFPLEY -i testme.nut -af volume=0.05
