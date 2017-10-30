//Author: Eduardo Jesus Serna Leal
//A01196007
//Homework 9



// This function interpolates a matrix given its four corners
function make_interpolation(mid_x,mid_y,top_left,top_right,bottom_left,bottom_right)
    global mat

    // Interpolate the first and last row
    mat(top_left.i,mid_y) = (1 / 2.0) * (mat(top_left.i,top_left.j) + mat(top_right.i,top_right.j))
    mat(bottom_left.i,mid_y) = (1 / 2.0) * (mat(bottom_left.i,bottom_left.j) + mat(bottom_right.i,bottom_right.j))

    // Interpolate the first and last column
    mat(mid_x,top_left.j) = (1 / 2.0) * (mat(top_left.i,top_left.j) + mat(bottom_left.i,bottom_left.j))
    mat(mid_x,top_right.j) = (1 / 2.0) * (mat(top_right.i,top_right.j) + mat(bottom_right.i,bottom_right.j))

    //Interpolate center
    mat(mid_x,mid_y) = (1 / 4.0) * (mat(top_left.i,mid_y) + mat(bottom_left.i,mid_y) + mat(mid_x,top_left.j) + mat(mid_x,top_right.j))
endfunction

function interpolate(n, top_left,top_right,bottom_left,bottom_right)
    if n <= 2 then
        return
    else
        n = n  / 2 // We will now interpolate the n / 2 size matrix. If we were to interpolate a 6 by 6 matrix, we would now interpolate a 3 by 3 matrix
        begin = top_left.i
        last = top_right.j
        // These variables gives the respective middles from the current matrix
        mid_x = (top_left.i + bottom_left.i) / 2
        mid_y = (top_left.j + top_right.j) / 2

        // Interpolate the four current corners of the matrix
        make_interpolation(mid_x,mid_y,top_left,top_right,bottom_left,bottom_right)
        // Interpolate the top left matrix
        interpolate(n,struct('i',top_left.i,'j',top_left.j), struct('i',top_left.i,'j',mid_y), struct('i',mid_x,'j',top_left.j), struct('i',mid_x,'j',mid_y)) 
         // Interpolate the top right matrix
        interpolate(n,struct('i',top_right.i,'j',mid_y), struct('i',top_right.i,'j',top_right.j), struct('i',mid_x,'j',mid_y), struct('i',mid_x,'j',bottom_right.j))
        // Interpolate the bottom left matrix
        interpolate(n,struct('i',mid_x,'j',top_left.j), struct('i',mid_x,'j',mid_y), struct('i',bottom_left.i,'j',bottom_left.j), struct('i',bottom_left.i,'j',mid_y))
        // Interpolate the bottom right matrix
        interpolate(n,struct('i',mid_x,'j',mid_y), struct('i',mid_x,'j',bottom_right.j), struct('i',bottom_right.i,'j',mid_y), struct('i',bottom_right.i,'j',bottom_right.j))
    end
endfunction

global mat
n = 5
begin = 1
last = 2^n + 1
mat = zeros(last,last)

mat(begin,begin) = 3
mat(begin,last) = 10
mat(last,begin) = 5
mat(last,last) = 2

top_left = struct('i',begin,'j',begin)
top_right = struct('i',begin,'j',last)
bottom_left = struct('i',last,'j',begin)
bottom_right = struct('i',last,'j',last)

// Call recursive function
interpolate(last + 1, top_left,top_right,bottom_left,bottom_right)

surf(mat,'facecol','red','edgecol','blu')
disp(mat)
