;;;; sequences.lisp
;;;;
;;;; Copyright 2018-2019 Alexander Gutev
;;;;
;;;; Permission is hereby granted, free of charge, to any person
;;;; obtaining a copy of this software and associated documentation
;;;; files (the "Software"), to deal in the Software without
;;;; restriction, including without limitation the rights to use,
;;;; copy, modify, merge, publish, distribute, sublicense, and/or sell
;;;; copies of the Software, and to permit persons to whom the
;;;; Software is furnished to do so, subject to the following
;;;; conditions:
;;;;
;;;; The above copyright notice and this permission notice shall be
;;;; included in all copies or substantial portions of the Software.
;;;;
;;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;;;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;;;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;;;; OTHER DEALINGS IN THE SOFTWARE.

(in-package :generic-cl.impl)


;;;; Generic Sequence Functions

;;; Elements

(defgeneric elt (sequence index)
  (:documentation
   "Returns the element at index INDEX of SEQUENCE."))

(defgeneric (setf elt) (value sequence index)
  (:documentation
   "Sets the element at index INDEX of sequence SEQUENCE to VALUE."))

(defgeneric first (sequence)
  (:documentation
   "Returns the first element of SEQUENCE."))

(defgeneric last (sequence &optional n)
  (:documentation
   "Returns the N'th (default 0) element from the last element of
    SEQUENCE."))

(defgeneric erase (sequence index)
  (:documentation
   "Removes the element at index INDEX from the sequence SEQUENCE."))

;;; Length

(defgeneric length (sequence)
  (:documentation
   "Returns the number of elements in SEQUENCE."))

(defgeneric emptyp (sequence)
  (:documentation
   "Returns true if SEQUENCE is empty."))

(defgeneric clear (sequence)
  (:documentation
   "Destructively removes all elements from SEQUENCE."))

;;; Subsequence

(defgeneric subseq (sequence start &optional end)
  (:documentation
   "Returns a new sequence that is the sub-sequence of SEQUENCE
    between START and END."))

(defgeneric (setf subseq) (new-sequence sequence start &optional end)
  (:documentation
   "Replaces the elements of SEQUENCE between START and END with the
    elements of NEW-SEQUENCE. The shorter of the length of
    NEW-SEQUENCE and the number of elements between START and END
    determines how many elements of SEQUENCE are actually modified."))


;;; Sequence Operations

;; Replacing elements of a sequence

(defgeneric fill (sequence item &key start end)
  (:documentation
   "Destructively replaces the elements of SEQUENCE between START and
    END with ITEM. Returns SEQUENCE."))

(defgeneric replace (sequence1 sequence2 &key start1 end1 start2 end2)
  (:documentation
   "Destructively replaces the elements of SEQUENCE1, between START1
    and END1, with the elements of SEQUENCE2, between START2 and
    END2."))


;; Reduction

(defgeneric reduce (function sequence &key key from-end start end initial-value)
  (:documentation
   "Same as CL:REDUCE however is extensible to other sequence types
    besides CL:SEQUENCE."))


;; Count

(defgeneric count (item sequence &key from-end start end test key)
  (:documentation
   "Same as CL:COUNT however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric count-if (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:COUNT-IF however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric count-if-not (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:COUNT-IF-NOT however is extensible to other sequence
    types besides CL:SEQUENCE."))

;; Find

(defgeneric find (item sequence &key from-end start end test key)
  (:documentation
   "Same as CL:FIND however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric find-if (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:FIND-IF however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric find-if-not (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:FIND-IF-NOT however is extensible to other sequence
    types besides CL:SEQUENCE."))

;; Position

(defgeneric position (item sequence &key from-end start end test key)
  (:documentation
   "Same as CL:POSITION however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric position-if (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:POSITION-IF however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric position-if-not (predicate sequence &key from-end start end key)
  (:documentation
   "Same as CL:POSITION-IF-NOT however is extensible to other sequence
    types besides CL:SEQUENCE."))


;; Searching for/Comparing subsequences

(defgeneric search (sequence-1 sequence-2 &key from-end test key start1 start2 end1 end2)
  (:documentation
   "Same as CL:SEARCH however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric mismatch (sequence-1 sequence-2 &key from-end test key start1 start2 end1 end2)
  (:documentation
   "Same as CL:MISMATCH however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))


;; Reversing

(defgeneric reverse (sequence)
  (:documentation
   "Returns a new sequence of the same type as SEQUENCE and with the
    same elements in reverse order."))

(defgeneric nreverse (sequence)
  (:documentation
   "Same as REVERSE however SEQUENCE may be modified."))


;; Sorting

(defgeneric merge (sequence1 sequence2 predicate &key key)
  (:documentation
   "Returns a new sequence (of the same type as SEQUENCE1) containing
    the elements of SEQUENCE1 and SEQUENCE2. The elements are ordered
    according to the function PREDICATE.

    PREDICATE is a function of two arguments (an element from
    SEQUENCE1 and an element from SEQUENCE2), which should return true
    if and only if the first argument is strictly less than the second
    argument.

    KEY is a function of one argument, that is called (if it is
    non-NIL) on each element of SEQUENCE1 and SEQUENCE2 with the
    result passed on to the PREDICATE function.

    Unlike CL:MERGE this function is non-destructive."))

(defgeneric nmerge (sequence1 sequence2 predicate &key key)
  (:documentation
   "Same as MERGE however is permitted to destructively modify either
    SEQUENCE1 or SEQUENCE2."))


(defgeneric sort (sequence &key test key)
  (:documentation
   "Returns a new sequence of the same type as SEQUENCE, with the same
    elements sorted according to the order determined by the function
    TEST.

    TEST is a function of two arguments, which should return true if
    and only if the first argument is strictly less than the
    second. By default, TEST is GENERIC-CL:LESSP.

    If KEY is provided and is not NIL it is called on each element and
    the result returned by the function is passed on to TEST."))

(defgeneric stable-sort (sequence &key test key)
  (:documentation
   "Same as SORT however the sort operation is guaranteed to be
    stable, that is the order of elements which compare equal, under
    TEST, will be preserved."))


(defgeneric nsort (sequence &key test key)
  (:documentation
   "Same as SORT however is permitted to destructively modify
    SEQUENCE."))

(defgeneric stable-nsort (sequence &key test key)
  (:documentation
   "Same as STABLE-SORT however is permitted to destructively modify
    SEQUENCE."))


;; Substitute (Find and Replace)

(defgeneric substitute (new old sequence &key from-end test start end count key)
  (:documentation
   "Same as CL:SUBSTITUTE however is extensible to other sequence
    types besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric nsubstitute (new old sequence &key from-end test start end count key)
  (:documentation
   "Same as CL:NSUBSTITUTE however is extensible to other sequence
    types besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric substitute-if (new predicate sequence &key from-end start end count key)
  (:documentation
   "Same as CL:SUBSTITUTE-IF however is extensible to other sequence
    types besides CL:SEQUENCE."))

(defgeneric nsubstitute-if (new predicate sequence &key from-end start end count key)
  (:documentation
   "Same as CL:NSUBSTITUTE-IF however is extensible to other sequence
    types besides CL:SEQUENCE."))

(defgeneric substitute-if-not (new predicate sequence &key from-end start end count key)
  (:documentation
   "Same as CL:SUBSTITUTE-IF-NOT however is extensible to other
    sequence types besides CL:SEQUENCE."))

(defgeneric nsubstitute-if-not (new predicate sequence &key from-end start end count key)
  (:documentation
   "Same as CL:NSUBSTITUTE-IF-NOT however is extensible to other
    sequence types besides CL:SEQUENCE."))


;; Removing Items

(defgeneric remove (item sequence &key from-end test start end count key)
  (:documentation
   "Same as CL:REMOVE however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric delete (item sequence &key from-end test start end count key)
  (:documentation
   "Same as CL:DELETE however is extensible to other sequence types
    besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric remove-if (test sequence &key from-end start end count key)
  (:documentation
   "Same as CL:REMOVE-IF however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric delete-if (test sequence &key from-end start end count key)
  (:documentation
   "Same as CL:DELETE-IF however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric remove-if-not (test sequence &key from-end start end count key)
  (:documentation
   "Same as CL:REMOVE-IF-NOT however is extensible to other sequence types
    besides CL:SEQUENCE."))

(defgeneric delete-if-not (test sequence &key from-end start end count key)
  (:documentation
   "Same as CL:DELETE-IF-NOT however is extensible to other sequence types
    besides CL:SEQUENCE."))


;; Removing Duplicates

(defgeneric remove-duplicates (sequence &key from-end test start end key)
  (:documentation
   "Same as CL:REMOVE-DUPLICATES however is extensible to other
    sequence types besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))

(defgeneric delete-duplicates (sequence &key from-end test start end key)
  (:documentation
   "Same as CL:DELETE-DUPLICATES however is extensible to other
    sequence types besides CL:SEQUENCE.

    The default TEST function is GENERIC-CL:EQUALP. The TEST-NOT
    argument is removed."))
